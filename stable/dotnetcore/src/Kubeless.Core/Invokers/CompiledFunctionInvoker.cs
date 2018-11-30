using Kubeless.Core.Interfaces;
using Kubeless.Core.Utils;
using Kubeless.Functions;
using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;

namespace Kubeless.Core.Invokers
{
    public class CompiledFunctionInvoker : IInvoker
    {
        public IFunction Function { get; }

        private readonly int functionTimeout;
        private readonly Type functionType;

        public CompiledFunctionInvoker(IFunction function, int functionTimeout, string referencesPath)
        {
            this.Function = function;
            this.functionTimeout = functionTimeout;
            this.functionType = GetFunctionType(function);

            // Load dependencies
            LoadDependentAssemblies(referencesPath);
        }

        private Type GetFunctionType(IFunction function)
        {
            Assembly assembly = LoadAssemblyFromFile(function);

            int namespacesCount = assembly.GetTypes().Select(t => t.Namespace).Distinct().Count();

            if (namespacesCount > 1)
                throw new InvalidOperationException("Multiple namespaces per assembly are not supported this time. Please use one or zero namespaces");

            var type = TryGetType(assembly, function.ModuleName, namespacesCount);
            if (type != null)
                return type;

            var namespacedType = TryGetNamespacedType(assembly, function.ModuleName, namespacesCount);
            if (namespacedType != null)
                return namespacedType;

            throw new InvalidOperationException($"Your module ({function.ModuleName}) was not found in this assembly.");
        }

        private Type TryGetType(Assembly assembly, string moduleName, int namespacesCount)
        {
            var type = assembly.GetType(moduleName);

            if (namespacesCount == 0 && type == null)
                throw new InvalidOperationException($"Your module ({moduleName}) was not found in this assembly.");

            return type;
        }

        private Type TryGetNamespacedType(Assembly assembly, string moduleName, int namespacesCount)
        {
            var @namespace = GetFunctionNamespaceName(assembly);
            var fullname = $"{@namespace}.{moduleName}";

            var namespacedType = assembly.GetType(fullname);

            if (namespacedType == null)
                throw new InvalidOperationException($"Your module ({fullname}) was not found in this assembly.");

            return namespacedType;
        }

        private string GetFunctionNamespaceName(Assembly assembly)
        {
            return assembly.GetTypes().Select(t => t.Namespace).First();
        }

        private Assembly LoadAssemblyFromFile(IFunction function)
        {
            var Assemblycontent = File.ReadAllBytes(function.FunctionFile);
            var assembly = Assembly.Load(Assemblycontent);

            return assembly;
        }

        private void LoadDependentAssemblies(string referencesPath)
        {
            var invocationManager = new CustomReferencesManager();
            var references = invocationManager.GetReferences(referencesPath);

            foreach (var r in references)
                Assembly.LoadFrom(r);
        }

        private object InvokeFunction(object[] parameters, Type type, object instance)
        {
            // Execute the function
            return type.InvokeMember(Function.FunctionHandler,
                                     BindingFlags.Default | BindingFlags.InvokeMethod,
                                     null,
                                     instance,
                                     parameters);
        }

        public object Execute(CancellationTokenSource cancellationSource, Event kubelessEvent, Context kubelessContext)
        {
            // Instantiates a new function
            object instance = Activator.CreateInstance(functionType);

            // Sets function timeout
            cancellationSource.CancelAfter(functionTimeout);
            var cancellationToken = cancellationSource.Token;

            // Invoke function
            object functionOutput = null;
            var task = Task.Run(() =>
            {
                functionOutput = InvokeFunction(new object[] { kubelessEvent, kubelessContext }, functionType, instance);
            });

            // Wait for function execution. If the timeout is achived, the invoker exits
            task.Wait(cancellationToken);

            return functionOutput;
        }
    }
}

using Kubeless.Core.Interfaces;
using Kubeless.Core.Utils;
using Kubeless.Functions;
using System;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;

namespace Kubeless.Core.Invokers
{
    public class CompiledFunctionInvoker : IInvoker
    {
        public IFunction Function { get; }

        private readonly int functionTimeout;
        private readonly Type type;

        public CompiledFunctionInvoker(IFunction function, int functionTimeout, string referencesPath)
        {
            this.Function = function;
            this.functionTimeout = functionTimeout;
            this.type = GetFunctionType(function);

            // Load dependencies
            LoadDependentAssemblies(referencesPath);
        }

        private Type GetFunctionType(IFunction function)
        {
            var Assemblycontent = File.ReadAllBytes(function.FunctionFile);
            var assembly = Assembly.Load(Assemblycontent);

            return assembly.GetType(function.ModuleName);
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
            object instance = Activator.CreateInstance(type);

            // Sets function timeout
            cancellationSource.CancelAfter(functionTimeout);
            var cancellationToken = cancellationSource.Token;

            // Invoke function
            object functionOutput = null;
            var task = Task.Run(() =>
            {
                functionOutput = InvokeFunction(new object[] { kubelessEvent, kubelessContext }, type, instance);
            });

            // Wait for function execution. If the timeout is achived, the invoker exits
            task.Wait(cancellationToken);

            return functionOutput;
        }
    }
}

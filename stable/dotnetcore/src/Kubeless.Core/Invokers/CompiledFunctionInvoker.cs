using Kubeless.Core.Interfaces;
using Kubeless.Functions;
using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using System.Threading.Tasks;

namespace Kubeless.Core.Invokers
{
    public class CompiledFunctionInvoker : IInvoker
    {
        public IFunction Function { get; }
        private readonly MethodInfo _methodInfo;
        private readonly dynamic _moduleInstance;
        private readonly int _functionTimeout;

        public CompiledFunctionInvoker(IFunction function, int functionTimeout)
        {
            Function = function;
            _functionTimeout = functionTimeout;

            var assemblyFolder = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            var functionAssemblyPath = Path.Combine(assemblyFolder, $"{function.AssemblyName}.dll");
            var functionAssembly = LoadAssembly(functionAssemblyPath);

            var moduleType = functionAssembly.GetType(function.ModuleName);
            _moduleInstance = Activator.CreateInstance(moduleType);

            _methodInfo = moduleType.GetMethod(function.FunctionHandler);
        }

        private Assembly LoadAssembly(string path)
        {
            try {
                return AssemblyLoadContext.Default.LoadFromAssemblyPath(path);
            } catch (FileLoadException exc) when (exc.Message.Contains("Assembly with same name is already loaded")) {
                // We need to check the exception message because 
                // LoadFromAssemblyPath does not throw a specialized Exception 
                // when an Assembly has already been loaded
                var assemblyName = AssemblyName.GetAssemblyName(path).Name;
                return AssemblyLoadContext.Default.Assemblies.SingleOrDefault(assembly => assembly.GetName().Name == assemblyName);
            }
        }

        public async Task<object> Execute(Event kubelessEvent, Context kubelessContext)
        {
            Task<object> resultTask = _methodInfo.Invoke(_moduleInstance, new object[] {kubelessEvent, kubelessContext});

            var firstCompletedTask = await Task.WhenAny(resultTask, Task.Delay(_functionTimeout));
            if (firstCompletedTask == resultTask) {
                return await resultTask;
            } else { 
                throw new OperationCanceledException("Function timeout");
            }
        }
    }
}

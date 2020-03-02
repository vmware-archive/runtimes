using Kubeless.Core.Interfaces;
using Kubeless.Core.Invokers;
using Kubeless.Core.Models;

namespace Kubeless.Core.Tests.Utils
{
    public class InvokerFactory
    {
        public static IInvoker GetFunctionInvoker(
            string language, string functionName, string moduleName, string functionHandler,
            int timeout = 180000)
        {
            FunctionCompiler.PublishTestFunction(language, functionName);

            var function = new CompiledFunction(moduleName, functionHandler, functionName);
            var invoker = new CompiledFunctionInvoker(function, timeout);

            return invoker;
        }
    }
}

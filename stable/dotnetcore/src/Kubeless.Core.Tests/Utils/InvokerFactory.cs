using System;
using Kubeless.Core.Interfaces;
using Kubeless.Core.Invokers;
using Kubeless.Core.Models;
using System.IO;

namespace Kubeless.Core.Tests.Utils
{
    public class InvokerFactory
    {
        public static IInvoker GetFunctionInvoker(
            string language, string functionName, string moduleName, string functionHandler,
            int timeout = 180000)
        {
            FunctionCompiler.PublishTestFunction(language, functionName);
            var publishPath = Environment.GetEnvironmentVariable("PUBLISH_PATH");

            var function = new CompiledFunction(moduleName, functionHandler, publishPath, functionName);
            var invoker = new CompiledFunctionInvoker(function, timeout, publishPath);

            return invoker;
        }
    }
}

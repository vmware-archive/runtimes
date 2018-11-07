using Kubeless.Core.Interfaces;
using Kubeless.Functions;
using System;
using System.Threading;

namespace Kubeless.Core.Invokers
{
    public class ScriptedFunctionInvoker : IInvoker
    {
        public IFunction Function => throw new NotImplementedException();

        public object Execute(CancellationTokenSource cancellationSource, Event kubelessEvent, Context kubelessContext)
        {
            // TODO: Create Roslyn C# Scripting
            // https://github.com/kubeless/kubeless/pull/758

            throw new NotImplementedException();
        }
    }
}

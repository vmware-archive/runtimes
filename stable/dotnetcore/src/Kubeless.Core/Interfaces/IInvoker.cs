using Kubeless.Functions;
using System.Threading;

namespace Kubeless.Core.Interfaces
{
    public interface IInvoker
    {
        IFunction Function { get; }

        object Execute(CancellationTokenSource cancellationSource, Event kubelessEvent, Context kubelessContext);
    }
}

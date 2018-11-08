using Kubeless.Core.Interfaces;
using Kubeless.Core.Tests.Utils;
using Kubeless.Functions;
using System;
using System.Threading;
using Xunit;

namespace Kubeless.Core.Tests
{
    public class TimeoutTests
    {
        [InlineData("cs", "timeout", "module", "handler", 5, 1)]
        [InlineData("cs", "timeout", "module", "handler", 5, 2)]
        [InlineData("cs", "timeout", "module", "handler", 5, 3)]
        [InlineData("cs", "timeout", "module", "handler", 5, 4)]
        [Theory]
        public void RunWithExecutionTimeGreaterThanTimeout(string language, string functionFileName, string moduleName, string functionHandler, int durationTime, int timeoutSeconds)
        {
            // Arrange
            int sleepTime = durationTime * 1000;
            int timeout = timeoutSeconds * 1000;
            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler, timeout);
            Event @event = new Event(sleepTime);
            Context context = new Context();
            CancellationTokenSource token = new CancellationTokenSource();

            // Act
            Action timeoutAction = () =>
            {
                object result = invoker.Execute(token, @event, context);
            };

            //Assert
            Assert.Throws<OperationCanceledException>(timeoutAction);
        }

        [InlineData("cs", "timeout", "module", "handler", 5, 5)]
        [InlineData("cs", "timeout", "module", "handler", 5, 6)]
        [InlineData("cs", "timeout", "module", "handler", 5, 7)]
        [InlineData("cs", "timeout", "module", "handler", 5, 8)]
        [InlineData("cs", "timeout", "module", "handler", 5, 9)]
        [InlineData("cs", "timeout", "module", "handler", 5, 10)]
        [Theory]
        public void RunWithoutTimeout(string language, string functionFileName, string moduleName, string functionHandler, int durationTime, int timeoutSeconds)
        {
            // Arrange
            int sleepTime = durationTime * 1000;
            int timeout = timeoutSeconds * 1000;
            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler, timeout);
            Event @event = new Event(sleepTime);
            Context context = new Context();
            CancellationTokenSource token = new CancellationTokenSource();

            // Act
            object result = invoker.Execute(token, @event, context);

            // Assert
            Assert.Equal("This is a long run!", result.ToString());
        }

    }
}

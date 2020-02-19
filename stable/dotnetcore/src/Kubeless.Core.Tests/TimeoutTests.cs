using Kubeless.Core.Interfaces;
using Kubeless.Core.Tests.Utils;
using Kubeless.Functions;
using System;
using Xunit;

namespace Kubeless.Core.Tests
{
    public class TimeoutTests
    {
        [InlineData("cs", "timeout", "module", "handler", 50, 10)]
        [InlineData("cs", "timeout", "module", "handler", 50, 20)]
        [InlineData("cs", "timeout", "module", "handler", 50, 30)]
        [InlineData("cs", "timeout", "module", "handler", 50, 40)]
        [Theory]
        public void RunWithExecutionTimeGreaterThanTimeout(string language, string functionFileName, string moduleName, string functionHandler, int durationTime, int timeout)
        {
            // Arrange
            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler, timeout);
            Event @event = new Event(durationTime);
            Context context = new Context();

            //Assert
            Assert.ThrowsAsync<OperationCanceledException>(async () => await invoker.Execute(@event, context));
        }

        [InlineData("cs", "timeout", "module", "handler", 49, 50)]
        [InlineData("cs", "timeout", "module", "handler", 50, 60)]
        [InlineData("cs", "timeout", "module", "handler", 50, 70)]
        [InlineData("cs", "timeout", "module", "handler", 50, 80)]
        [InlineData("cs", "timeout", "module", "handler", 50, 90)]
        [InlineData("cs", "timeout", "module", "handler", 50, 100)]
        [Theory]
        public async void RunWithoutTimeout(string language, string functionFileName, string moduleName, string functionHandler, int durationTime, int timeout)
        {
            // Arrange
            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler, timeout);
            Event @event = new Event(durationTime);
            Context context = new Context();

            // Act
            object result = await invoker.Execute(@event, context);

            // Assert
            Assert.Equal("This is a long run!", result.ToString());
        }

    }
}
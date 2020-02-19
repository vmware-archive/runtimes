using Kubeless.Core.Tests.Utils;
using Kubeless.Functions;
using Xunit;

namespace Kubeless.Core.Tests
{
    public class InvocationTests
    {
        [InlineData("cs", "helloget", "module", "handler")]
        [InlineData("cs", "dependency-yaml", "module", "handler")]
        [Theory]
        public async void InvokeRegularFunction(string language, string functionName, string moduleName, string functionHandler)
        {
            // Arrange
            var invoker = InvokerFactory.GetFunctionInvoker(language, functionName, moduleName, functionHandler);
            var @event = new Event();
            var context = new Context();

            // Act
            var result = await invoker.Execute(@event, context);
        }

        [InlineData("cs", "hellowithdata", "module", "handler")]
        [Theory]
        public async void InvokeRegularFunctionWithData(string language, string functionName, string moduleName, string functionHandler)
        {
            // Arrange
            var inputData = "expected returned message";

            var invoker = InvokerFactory.GetFunctionInvoker(language, functionName, moduleName, functionHandler);
            var @event = new Event(inputData);
            var context = new Context();

            // Act
            object result = await invoker.Execute(@event, context);

            // Assert
            Assert.Equal(inputData, result.ToString());
        }
    }
}

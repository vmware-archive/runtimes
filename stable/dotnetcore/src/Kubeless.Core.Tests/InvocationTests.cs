using Kubeless.Core.Interfaces;
using Kubeless.Core.Tests.Utils;
using Kubeless.Functions;
using System.Threading;
using Xunit;

namespace Kubeless.Core.Tests
{
    public class InvocationTests
    {
        [InlineData("cs", "helloget", "module", "handler")]
        [InlineData("cs", "namespaced-helloget", "module", "handler")]
        [InlineData("cs", "dependency-yaml", "module", "handler")]
        [Theory]
        public void InvokeRegularFunction(string language, string functionFileName, string moduleName, string functionHandler)
        {
            // Arrange
            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler);
            Event @event = new Event();
            Context context = new Context();
            CancellationTokenSource token = new CancellationTokenSource();

            // Act
            object result = invoker.Execute(token, @event, context);

            // Assert
        }

        [InlineData("cs", "hellowithdata", "module", "handler")]
        [Theory]
        public void InvokeRegularFunctionWithData(string language, string functionFileName, string moduleName, string functionHandler)
        {
            // Arrange
            string inputData = "expected returned message";

            IInvoker invoker = InvokerFactory.GetFunctionInvoker(language, functionFileName, moduleName, functionHandler);
            Event @event = new Event(inputData);
            Context context = new Context();
            CancellationTokenSource token = new CancellationTokenSource();

            // Act
            object result = invoker.Execute(token, @event, context);

            // Assert
            Assert.Equal(inputData, result.ToString());
        }
    }
}

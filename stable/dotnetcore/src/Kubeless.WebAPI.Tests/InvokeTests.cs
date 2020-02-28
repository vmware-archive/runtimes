using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    [Collection("health-check")]
    public class InvokeTests : IClassFixture<KubelessWebApplicationFactory<Kubeless.WebAPI.Startup>>
    {
        private readonly KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> _factory;
        public InvokeTests(KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> factory)
        {
            _factory = factory;
        }

        [InlineData("GET", "cs", "helloget", "module", "handler", "hello world")]
        [InlineData("GET", "cs", "hellowithdata", "module", "handler", "")]
        [InlineData("GET", "cs", "dependency-yaml", "module", "handler", "Name: Michael J. Fox\nAge: 56\n")]
        [InlineData("POST", "cs", "helloget", "module", "handler", "hello world")]
        [InlineData("POST", "cs", "hellowithdata", "module", "handler", "")]
        [InlineData("POST", "cs", "dependency-yaml", "module", "handler", "Name: Michael J. Fox\nAge: 56\n")]
        [InlineData("PUT", "cs", "helloget", "module", "handler", "hello world")]
        [InlineData("PUT", "cs", "hellowithdata", "module", "handler", "")]
        [InlineData("PUT", "cs", "dependency-yaml", "module", "handler", "Name: Michael J. Fox\nAge: 56\n")]
        [InlineData("PATCH", "cs", "helloget", "module", "handler", "hello world")]
        [InlineData("PATCH", "cs", "hellowithdata", "module", "handler", "")]
        [InlineData("PATCH", "cs", "dependency-yaml", "module", "handler", "Name: Michael J. Fox\nAge: 56\n")]
        [InlineData("DELETE", "cs", "helloget", "module", "handler", "hello world")]
        [InlineData("DELETE", "cs", "hellowithdata", "module", "handler", "")]
        [InlineData("DELETE", "cs", "dependency-yaml", "module", "handler", "Name: Michael J. Fox\nAge: 56\n")]
        [Theory]
        public async Task InvokeFunctionsThroughAPI(string httpMethod, string language, string functionName, string moduleName, string functionHandler, object expectedResponse)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler);
            FunctionCompiler.PublishTestFunction(language, functionName);
            var client = _factory.CreateClient();
            var request = new HttpRequestMessage(new HttpMethod(httpMethod), "/");

            // Act
            var response = await client.SendAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
            Assert.Equal(expectedResponse, await response.Content.ReadAsStringAsync());
        }
    }
}

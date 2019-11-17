using System.Net;
using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using Microsoft.AspNetCore.TestHost;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    [Collection("metrics-test")]
    public class MetricsTests
    {
        [InlineData("cs", "helloget", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "hellowithdata", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "dependency-yaml", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "namespaced-helloget", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "err", "module", "handler", HttpStatusCode.InternalServerError)]
        [Theory]
        public async Task PerformMetricsTest(string language, string functionFileName, string moduleName, string functionHandler, HttpStatusCode expectedResponse)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler, funcRuntime: "dotnetcore2.2");
            ServerCreator.CompileFunction(language, functionFileName, moduleName, functionHandler);
            TestServer server = ServerCreator.CreateServer();
            HttpClient client = server.CreateClient();

            var request = new HttpRequestMessage(new HttpMethod("GET"), "/");
            var invokeResponse = await client.SendAsync(request);
            Assert.Equal(expectedResponse, invokeResponse.StatusCode);

            // Act
            var response = await client.GetAsync("/metrics");

            // Assert
            response.EnsureSuccessStatusCode();
            var responseBody = await response.Content.ReadAsStringAsync();
            Assert.Contains("kubeless_calls_total", responseBody);
            Assert.Contains($"status=\"{(int) expectedResponse}\"", responseBody);
            Assert.Contains("function=\"handler\"", responseBody);
            Assert.Contains("runtime=\"dotnetcore2.2\"", responseBody);
            Assert.Contains("handler=\"module\"", responseBody);
        }
    }
}
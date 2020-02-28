using System.Net;
using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    [Collection("metrics-test")]
    public class MetricsTests : IClassFixture<KubelessWebApplicationFactory<Kubeless.WebAPI.Startup>>
    {
        private readonly KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> _factory;
        public MetricsTests(KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> factory)
        {
            _factory = factory;
        }

        [InlineData("cs", "helloget", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "hellowithdata", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "dependency-yaml", "module", "handler", HttpStatusCode.OK)]
        [InlineData("cs", "err", "module", "handler", HttpStatusCode.InternalServerError)]
        [Theory]
        public async Task PerformMetricsTest(string language, string functionName, string moduleName, string functionHandler, HttpStatusCode expectedResponse)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler, funcRuntime: "dotnetcore3.1");
            FunctionCompiler.PublishTestFunction(language, functionName);
            HttpClient client = _factory.CreateClient();

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
            Assert.Contains("runtime=\"dotnetcore3.1\"", responseBody);
            Assert.Contains("handler=\"module\"", responseBody);
        }
    }
}
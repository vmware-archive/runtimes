using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    [Collection("health-check")]
    public class HealthTests : IClassFixture<KubelessWebApplicationFactory<Kubeless.WebAPI.Startup>>
    {
        private readonly KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> _factory;
        public HealthTests(KubelessWebApplicationFactory<Kubeless.WebAPI.Startup> factory)
        {
            _factory = factory;
        }

        [InlineData("cs", "helloget", "module", "handler")]
        [InlineData("cs", "hellowithdata", "module", "handler")]
        [InlineData("cs", "dependency-yaml", "module", "handler")]
        [Theory]
        public async Task PerformHealthCheck(string language, string functionName, string moduleName, string functionHandler)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler);
            FunctionCompiler.PublishTestFunction(language, functionName);
            HttpClient client = _factory.CreateClient();

            // Act
            var response = await client.GetAsync("/healthz");

            // Assert
            response.EnsureSuccessStatusCode();
        }
    }
}

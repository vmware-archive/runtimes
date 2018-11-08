using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using Microsoft.AspNetCore.TestHost;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    public class HealthTests
    {
        [InlineData("cs", "helloget", "module", "handler")]
        [InlineData("cs", "hellowithdata", "module", "handler")]
        [InlineData("cs", "dependency-yaml", "module", "handler")]
        [Theory]
        public async Task PerformHealthCheck(string language, string functionFileName, string moduleName, string functionHandler)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler);
            ServerCreator.CompileFunction(language, functionFileName, moduleName, functionHandler);
            TestServer server = ServerCreator.CreateServer();
            HttpClient client = server.CreateClient();

            // Act
            var response = await client.GetAsync("/healthz");

            // Assert
            response.EnsureSuccessStatusCode();
        }
    }
}

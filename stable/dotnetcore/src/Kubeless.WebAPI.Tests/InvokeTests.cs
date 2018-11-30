using Kubeless.Core.Tests.Utils;
using Kubeless.WebAPI.Tests.Utils;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace Kubeless.WebAPI.Tests
{
    public class InvokeTests
    {
        [InlineData("GET", "cs", "helloget", "module", "handler")]
        [InlineData("GET", "cs", "hellowithdata", "module", "handler")]
        [InlineData("GET", "cs", "dependency-yaml", "module", "handler")]
        [InlineData("GET", "cs", "namespaced-helloget", "module", "handler")]
        [InlineData("POST", "cs", "helloget", "module", "handler")]
        [InlineData("POST", "cs", "hellowithdata", "module", "handler")]
        [InlineData("POST", "cs", "dependency-yaml", "module", "handler")]
        [InlineData("POST", "cs", "namespaced-helloget", "module", "handler")]
        [InlineData("PUT", "cs", "helloget", "module", "handler")]
        [InlineData("PUT", "cs", "hellowithdata", "module", "handler")]
        [InlineData("PUT", "cs", "dependency-yaml", "module", "handler")]
        [InlineData("PUT", "cs", "namespaced-helloget", "module", "handler")]
        [InlineData("PATCH", "cs", "helloget", "module", "handler")]
        [InlineData("PATCH", "cs", "hellowithdata", "module", "handler")]
        [InlineData("PATCH", "cs", "dependency-yaml", "module", "handler")]
        [InlineData("PATCH", "cs", "namespaced-helloget", "module", "handler")]
        [InlineData("DELETE", "cs", "helloget", "module", "handler")]
        [InlineData("DELETE", "cs", "hellowithdata", "module", "handler")]
        [InlineData("DELETE", "cs", "dependency-yaml", "module", "handler")]
        [InlineData("DELETE", "cs", "namespaced-helloget", "module", "handler")]
        [Theory]
        public async Task InvokeFunctionsThroughAPI(string httpMethod, string language, string functionFileName, string moduleName, string functionHandler)
        {
            // Arrange
            EnvironmentManager.SetVariables(moduleName, functionHandler);
            ServerCreator.CompileFunction(language, functionFileName, moduleName, functionHandler);
            TestServer server = ServerCreator.CreateServer();
            HttpClient client = server.CreateClient();
            HttpRequestMessage request = new HttpRequestMessage(new HttpMethod(httpMethod), "/");

            // Act
            var response = await client.SendAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
        }
    }
}

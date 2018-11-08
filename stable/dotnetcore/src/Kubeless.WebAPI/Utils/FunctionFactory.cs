using Kubeless.Core.Interfaces;
using Kubeless.Core.Models;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace Kubeless.WebAPI.Utils
{
    public class FunctionFactory
    {
        private static readonly string BASE_PATH = VariablesUtils.GetEnvVar("BASE_PATH", "/kubeless/");
        private static readonly string PUBLISH_PATH = VariablesUtils.GetEnvVar("PUBLISH_PATH", "publish/");
        private static readonly string PACKAGES_PATH = VariablesUtils.GetEnvVar("PACKAGES_PATH", "packages/");

        public static IFunction GetFunction(IConfiguration configuration)
        {
            var moduleName = configuration.GetNotNullConfiguration("MOD_NAME");
            var functionHandler = configuration.GetNotNullConfiguration("FUNC_HANDLER");
            var publishPath = Path.Combine(BASE_PATH, PUBLISH_PATH);

            return new CompiledFunction(moduleName, functionHandler, publishPath);
        }

        public static int GetFunctionTimeout(IConfiguration configuration)
        {
            var timeoutSeconds = configuration.GetNotNullConfiguration("FUNC_TIMEOUT");
            var milisecondsInSecond = 1000;

            return int.Parse(timeoutSeconds) * milisecondsInSecond;
        }

        public static string GetFunctionReferencesPath(IConfiguration configuration)
        {
            var referencesPath = Path.Combine(BASE_PATH, PACKAGES_PATH);

            return referencesPath;
        }
    }
}

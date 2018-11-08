using Kubeless.Core.Interfaces;
using Kubeless.Core.Tests.Utils;
using Microsoft.AspNetCore.TestHost;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Kubeless.WebAPI.Tests.Utils
{
    public class ServerCreator
    {
        private const string BASE_PATH = "./functions-tests";
        private const string PACKAGES_SUBPATH = "packages/";

        public static TestServer CreateServer()
        {
            return new TestServer(Program.CreateWebHostBuilder());
        }

        public static void CompileFunction(string language, string functionFileName, string moduleName, string functionHandler)
        {
            FunctionFactory factory = new FunctionFactory(BASE_PATH, PACKAGES_SUBPATH);
            string functionPath = factory.CreateEnvironmentPath(BASE_PATH, language, functionFileName);
            IFunction function = factory.CompileFunction(functionPath, moduleName, functionHandler);

            Environment.SetEnvironmentVariable("BASE_PATH", functionPath);
            Environment.SetEnvironmentVariable("PUBLISH_PATH", ".");
        }
    }
}

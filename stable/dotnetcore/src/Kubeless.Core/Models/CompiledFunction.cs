using Kubeless.Core.Interfaces;
using System.IO;

namespace Kubeless.Core.Models
{
    public class CompiledFunction : IFunction
    {
        private const string BINARY_NAME = "project.dll";

        public string ModuleName { get; }
        public string FunctionHandler { get; }
        public string FunctionFile { get; }

        public CompiledFunction(string moduleName, string functionHandler, string basePath)
        {
            ModuleName = moduleName;
            FunctionHandler = functionHandler;
            FunctionFile = Path.Combine(basePath, BINARY_NAME);
        }
    }
}

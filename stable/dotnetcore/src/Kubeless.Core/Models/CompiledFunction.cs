using Kubeless.Core.Interfaces;
using System.IO;

namespace Kubeless.Core.Models
{
    public class CompiledFunction : IFunction
    {
        public string ModuleName { get; }
        public string FunctionHandler { get; }
        public string FunctionFile { get; }

        public CompiledFunction(string moduleName, string functionHandler, string publishPath, string assemblyName)
        {
            ModuleName = moduleName;
            FunctionHandler = functionHandler;
            FunctionFile = Path.Combine(publishPath, $"{assemblyName}.dll");
        }
    }
}

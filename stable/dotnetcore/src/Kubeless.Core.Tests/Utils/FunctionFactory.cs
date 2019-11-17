using Kubeless.Core.Interfaces;
using Kubeless.Core.Models;
using System.Collections.Generic;
using System.IO;

namespace Kubeless.Core.Tests.Utils
{
    public class FunctionFactory
    {
        private readonly string basePath;
        private readonly string packagesSubPath;
        private readonly FunctionCompiler compiler;

        public FunctionFactory(string basePath, string packagesSubPath)
        {
            this.basePath = basePath;
            this.packagesSubPath = packagesSubPath;

            this.compiler = new FunctionCompiler();
        }

        public IFunction CompileFunction(string functionPath, string moduleName, string functionHandler)
        {
            var binaryPath = compiler.Compile(functionPath, packagesSubPath);

            return new CompiledFunction(moduleName, functionHandler, binaryPath);
        }

        public string CreateEnvironmentPath(string basePath, string language, string functionFileName)
        {
            var environmentPath = Path.Combine(basePath, language, functionFileName);
            CreateDirectory(environmentPath);

            var functionFiles = Directory.EnumerateFiles(".", $"{functionFileName}.{language}*");
            CopyFunctionsFiles(functionFiles, environmentPath);

            return environmentPath;
        }

        private void CreateDirectory(string directory)
        {
            if (Directory.Exists(directory))
                Directory.Delete(directory, recursive: true);
            Directory.CreateDirectory(directory);
        }

        private void CopyFunctionsFiles(IEnumerable<string> files, string destination)
        {
            foreach (var file in files)
            {
                var name = Path.GetFileNameWithoutExtension(file);
                var extension = Path.GetExtension(file);
                var newName = "project" + extension;
                File.Copy(file, Path.Combine(destination, newName));
            }
        }
    }
}

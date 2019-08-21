using System;
using System.Diagnostics;
using System.IO;

namespace Kubeless.Core.Tests.Utils
{
    /// <summary>
    /// Simulates dependency restore executed in init container by Kubeless.
    /// </summary>
    public class FunctionCompiler
    {
        public FunctionCompiler()
        {
        }

        private void DotnetPublish(string functionPath, string referencesPath, string destinationPath)
        {
            var process = new Process()
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "dotnet",
                    Arguments = $"publish --packages {referencesPath} -c Release -o {destinationPath}",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    WorkingDirectory = functionPath
                }
            };

            process.Start();

            string result = process.StandardOutput.ReadToEnd();

            process.WaitForExit();

            if (process.ExitCode != 0 || result.ToLower().Contains("error"))
                throw new Exception("Error during dotnet publish");
            }

        public string Compile(string functionPath, string packagesSubPath)
        {
            string outputPath = ".";

            DotnetPublish(functionPath, packagesSubPath, outputPath);

            return Path.Combine(functionPath, outputPath);
        }
    }
}

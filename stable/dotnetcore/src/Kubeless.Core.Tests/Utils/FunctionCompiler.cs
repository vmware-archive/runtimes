using System;
using System.Diagnostics;
using System.IO;

namespace Kubeless.Core.Tests.Utils
{
    /// <summary>
    /// Simulates dependency restore executed in init container by Kubeless.
    /// </summary>
    public static class FunctionCompiler
    {
        public static void PublishTestFunction(string language, string functionName)
        {
            var workingDirectory = Directory.GetCurrentDirectory();

            var projPath = Path.Combine(workingDirectory, functionName, $"{functionName}.{language}proj");
            var publishPath = Path.Combine(workingDirectory, functionName, $"{functionName}-publish");
            Publish(projPath, publishPath);

            Environment.SetEnvironmentVariable("PUBLISH_PATH", Path.Combine(workingDirectory, functionName, $"{functionName}-publish"));
            Environment.SetEnvironmentVariable("ASSEMBLY_NAME", functionName);
        }

        public static void Publish(string projPath, string publishPath)
        {
            var process = new Process()
            {
                StartInfo = new ProcessStartInfo
                {
                    FileName = "dotnet",
                    Arguments = $"publish -c Release -o {publishPath} {projPath}",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                }
            };

            process.Start();

            string result = process.StandardOutput.ReadToEnd();

            process.WaitForExit();

            if (process.ExitCode != 0 || result.ToLower().Contains("error"))
                throw new Exception("Error during dotnet publish");
        }
    }
}
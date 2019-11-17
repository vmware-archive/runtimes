using System;
using Kubeless.WebAPI.Utils;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace Kubeless.WebAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                CreateWebHostBuilder(args)
                    .Build()
                    .Run();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }


        public static IWebHostBuilder CreateWebHostBuilder(string[] args)
        {
            var port = VariablesUtils.GetEnvVar("FUNC_PORT", "8080");

            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .UseUrls($"http://*:{port}")
                .ConfigureAppConfiguration((hostingContext, config) => { config.AddEnvironmentVariables(); })
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.AddConsole(options => options.IncludeScopes = true);
                    logging.AddDebug();
                });
        }
    }
}
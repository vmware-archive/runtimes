using Kubeless.WebAPI.Utils;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;
using Prometheus;

namespace Kubeless.WebAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(params string[] args)
        {
            var port = VariablesUtils.GetEnvVar("FUNC_PORT", "8080");

            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .UseUrls($"http://*:{port}")
                .Configure(app => app.UseMetricServer())
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.AddConsole(options => options.IncludeScopes = true);
                    logging.AddDebug();
                });
        }
    }
}

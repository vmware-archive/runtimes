using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Kubeless.Core.Invokers;
using Kubeless.Core.Interfaces;
using System.Linq;
using System;
using Kubeless.Core.Models;

namespace Kubeless.WebAPI.Tests.Utils
{
    // This custom WebApplicationFactory registers a transient CompiledFunctionInvoker that reloads CompiledFunction each time
    // this allows to test multiple functions in one test session
    public class KubelessWebApplicationFactory<TStartup> : WebApplicationFactory<TStartup> where TStartup: class
    {
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.ConfigureServices(services =>
            {
                var descriptor = services.SingleOrDefault(d => d.ServiceType == typeof(IInvoker));
                if (descriptor != null)
                {
                    services.Remove(descriptor);
                }
                services.AddTransient<IInvoker>(provider => {
                    Func<string, string> config = s => Environment.GetEnvironmentVariable(s);

                    var function = new CompiledFunction(config("MOD_NAME"), config("FUNC_HANDLER"), config("PUBLISH_PATH"), config("ASSEMBLY_NAME"));
                    var timeoutMs = int.Parse(config("FUNC_TIMEOUT")) * 1000;
                    return new CompiledFunctionInvoker(function, timeoutMs, config("PUBLISH_PATH"));
                });
            });
        }
    }
}
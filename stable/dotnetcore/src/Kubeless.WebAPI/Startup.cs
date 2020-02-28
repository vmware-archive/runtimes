using Kubeless.Core.Handlers;
using Kubeless.Core.Interfaces;
using Kubeless.Core.Invokers;
using Kubeless.WebAPI.Utils;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Prometheus;

namespace Kubeless.WebAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();

            var function = FunctionFactory.GetFunction(Configuration);
            var timeout = FunctionFactory.GetFunctionTimeout(Configuration);

            services.AddTransient<IInvoker>(_ => new CompiledFunctionInvoker(function, timeout, FunctionFactory.GetFunctionPublishPath()));
            services.AddSingleton<IParameterHandler>(new DefaultParameterHandler(Configuration));
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
                endpoints.MapControllers());

            app.UseCors(builder =>
                builder
                    .AllowAnyHeader()
                    .AllowAnyOrigin()
                    .AllowAnyMethod());
            
            app.UseMetricServer();
        }
    }
}

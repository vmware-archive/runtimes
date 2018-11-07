using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Kubeless.Core.Interfaces;
using Kubeless.WebAPI.Utils;
using Kubeless.Core.Invokers;
using System.IO;
using Kubeless.Core.Handlers;

namespace Kubeless.WebAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IHostingEnvironment env)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();

            var function = FunctionFactory.GetFunction(Configuration);
            var timeout = FunctionFactory.GetFunctionTimeout(Configuration);
            var referencesPath = FunctionFactory.GetFunctionReferencesPath(Configuration); 

            services.AddSingleton<IInvoker>(new CompiledFunctionInvoker(function, timeout, referencesPath));

            services.AddSingleton<IParameterHandler>(new DefaultParameterHandler(Configuration));
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
                app.UseDeveloperExceptionPage();

            app.UseCors(builder =>
                builder.AllowAnyHeader().AllowAnyOrigin().AllowAnyMethod());

            app.UseMvc();
        }
    }
}

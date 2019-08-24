using Kubeless.Core.Interfaces;
using Kubeless.Functions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Threading;
using Prometheus;

namespace Kubeless.WebAPI.Controllers
{
    [Route("/")]
    public class RuntimeController : Controller
    {
        private readonly IParameterHandler parameterHandler;
        private readonly IInvoker invoker;
        private readonly ILogger logger;

        private static readonly Counter CallsCountTotal = Metrics
            .CreateCounter("kubeless_calls_total", "Number of calls processed.", new CounterConfiguration
            {
                LabelNames = new[] {"status", "handler", "function", "runtime"}
            });

        public RuntimeController(IParameterHandler parameterHandler, IInvoker invoker, ILogger<RuntimeController> logger)
        {
            this.invoker = invoker;
            this.parameterHandler = parameterHandler;
            this.logger = logger;
        }

        [AcceptVerbs("GET", "POST", "PUT", "PATCH", "DELETE")]
        public object Execute()
        {
            logger.LogInformation("{0}: Function Started. HTTP Method: {1}, Path: {2}.", DateTime.Now.ToString(), Request.Method, Request.Path);

            Event @event = null;
            Context context = null;
            try
            {
                (@event, context) = parameterHandler.GetFunctionParameters(Request);
                var cancellationSource = new CancellationTokenSource();

                var output = invoker.Execute(cancellationSource, @event, context);

                logger.LogInformation("{0}: Function Executed. HTTP response: {1}.", DateTime.Now.ToString(), 200);

                LogMetrics(context, 200);
                return output;
            }
            catch (OperationCanceledException exception)
            {
                logger.LogError(exception, "{0}: Function Cancelled. HTTP Response: {1}. Reason: {2}.", DateTime.Now.ToString(), 408, "Timeout");
                LogMetrics(context, 408);
                return new StatusCodeResult(408);
            }
            catch (Exception exception)
            {
                logger.LogCritical(exception, "{0}: Function Corrupted. HTTP Response: {1}. Reason: {2}.", DateTime.Now.ToString(), 500, exception.Message);
                LogMetrics(context, 500);
                return new StatusCodeResult(500);
            }
        }

        [HttpGet("/healthz")]
        public IActionResult Health() => Ok();

        private void LogMetrics(Context context, int statusCode)
        {
            if (context != null)
            {
                CallsCountTotal
                    .WithLabels($"{statusCode}", context.ModuleName, context.FunctionName, context.Runtime)
                    .Inc();
            }
        }
    }
}
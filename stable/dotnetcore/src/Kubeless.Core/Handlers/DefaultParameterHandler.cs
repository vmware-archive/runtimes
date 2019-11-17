using Kubeless.Core.Interfaces;
using Kubeless.Functions;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.IO;

namespace Kubeless.Core.Handlers
{
    public class DefaultParameterHandler : IParameterHandler
    {
        private readonly IConfiguration configuration;

        public DefaultParameterHandler(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public (Event, Context) GetFunctionParameters(HttpRequest request)
        {
            var _event = GetEvent(request);
            var _context = GetContext();

            return (_event, _context);
        }

        private Event GetEvent(HttpRequest request)
        {
            if (request.Body.CanSeek)
                request.Body.Position = 0;

            var contentType = request.Headers["content-type"];

            object data = new StreamReader(request.Body).ReadToEnd();
            if (contentType == "application/json" && data.ToString().Length > 0)
                data = JsonConvert.DeserializeObject(data.ToString());

            string eventId = request.Headers["event-id"];
            string eventType = request.Headers["event-type"];
            string eventTime = request.Headers["event-time"];
            string eventNamespace = request.Headers["event-namespace"];

            var extensions = new Extensions(request);

            return new Event(data, eventId, eventType, eventTime, eventNamespace, extensions);
        }

        private Context GetContext()
        {
            var moduleName = configuration["MOD_NAME"];
            var functionName = configuration["FUNC_HANDLER"];
            var functionPort = configuration["FUNC_PORT"];
            var timeout = configuration["FUNC_TIMEOUT"];
            var runtime = configuration["FUNC_RUNTIME"];
            var memoryLimit = configuration["FUNC_MEMORY_LIMIT"];

            return new Context(moduleName, functionName, functionPort, timeout, runtime, memoryLimit);
        }
    }
}

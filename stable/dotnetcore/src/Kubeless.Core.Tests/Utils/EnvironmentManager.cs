using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Net.Http;
using System.Text;

namespace Kubeless.Core.Tests.Utils
{
    public static class EnvironmentManager
    {
        public static void SetVariables(string modName, string funcHandler, string funcTimeout = "180", string funcPort = "8080", string funcRuntime = "dotnetcore2.0", string funcMemoryLimit = "0")
        {
            Environment.SetEnvironmentVariable("MOD_NAME", modName);
            Environment.SetEnvironmentVariable("FUNC_HANDLER", funcHandler);
            Environment.SetEnvironmentVariable("FUNC_TIMEOUT", funcTimeout);
            Environment.SetEnvironmentVariable("FUNC_PORT", funcPort);
            Environment.SetEnvironmentVariable("FUNC_RUNTIME", funcRuntime);
            Environment.SetEnvironmentVariable("FUNC_MEMORY_LIMIT", funcMemoryLimit);
        }

        public static HttpRequest GetHttpRequest(string eventId = "", string eventType = "", string eventTime = "", string eventNamespace = "", object data = null)
        {
            var httpRequest = new DefaultHttpContext().Request;

            var msg = new HttpRequestMessage();

            httpRequest.Headers.Add("event-id", eventId);
            httpRequest.Headers.Add("event-type", eventType);
            httpRequest.Headers.Add("event-time", eventTime);
            httpRequest.Headers.Add("event-namespace", eventNamespace);

            if (data != null)
            {
                var str = JsonConvert.SerializeObject(data);
                byte[] bytes = Encoding.UTF8.GetBytes(str);

                httpRequest.Body = new MemoryStream();
                httpRequest.Body.Seek(0, SeekOrigin.Begin);

                BinaryWriter fs = new BinaryWriter(httpRequest.Body);
                fs.Write(bytes);

                httpRequest.ContentType = "application/json";
                httpRequest.ContentLength = bytes.Length;
            }

            return httpRequest;
        }
    }
}
using Kubeless.Core.Handlers;
using Kubeless.Core.Interfaces;
using Kubeless.Core.Tests.Utils;
using Kubeless.Functions;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using Xunit;
using System.Text.Json;

namespace Kubeless.Core.Tests
{
    public class ParametersTests
    {
        [InlineData("hello", "handler", "180", "8080", "dotnetcore2.0", "0")]
        [InlineData("hello", "handler", "360", "8080", "dotnetcore2.1", "0")]
        [InlineData("hello", "handler", "180", "8080", "dotnetcore2.2", "200m")]
        [InlineData("hello", "handler", "180", "9090", "dotnetcore2.0", "200m")]
        [InlineData("hellowithdata", "handler", "180", "9090", "dotnetcore2.0", "200m")]
        [Theory]
        public async void CheckContextFromDefaultParameterHandler(string modName, string funcHandler, string funcTimeout, string funcPort, string funcRuntime, string funcMemoryLimit)
        {
            // Arrange
            EnvironmentManager.SetVariables(modName, funcHandler, funcTimeout, funcPort, funcRuntime, funcMemoryLimit);
            IParameterHandler parameterHandler = GetDefaultParameterHandler();
            HttpRequest httpRequest = EnvironmentManager.GetHttpRequest();

            // Act
            (_, Context context) = await parameterHandler.GetFunctionParameters(httpRequest);

            // Assert
            Assert.NotNull(context);
            Assert.Equal(modName, context.ModuleName);
            Assert.Equal(funcHandler, context.FunctionName);
            Assert.Equal(funcTimeout, context.Timeout);
            Assert.Equal(funcPort, context.FunctionPort);
            Assert.Equal(funcRuntime, context.Runtime);
            Assert.Equal(funcMemoryLimit, context.MemoryLimit);
        }

        [InlineData("hello", "handler", "180", "8080", "dotnetcore2.0", "0")]
        [InlineData("hello", "handler", "360", "8080", "dotnetcore2.1", "0")]
        [InlineData("hello", "handler", "180", "8080", "dotnetcore2.2", "200m")]
        [InlineData("hello", "handler", "180", "9090", "dotnetcore2.0", "200m")]
        [InlineData("hellowithdata", "handler", "180", "9090", "dotnetcore2.0", "200m")]
        [Theory]
        public async void CheckDefaultEventFromDefaultParameterHandler(string modName, string funcHandler, string funcTimeout, string funcPort, string funcRuntime, string funcMemoryLimit)
        {
            // Arrange
            EnvironmentManager.SetVariables(modName, funcHandler, funcTimeout, funcPort, funcRuntime, funcMemoryLimit);
            IParameterHandler parameterHandler = GetDefaultParameterHandler();
            HttpRequest httpRequest = EnvironmentManager.GetHttpRequest();

            // Act
            (Event @event, _) = await parameterHandler.GetFunctionParameters(httpRequest);

            // Assert
            Assert.NotNull(@event);
            Assert.NotNull(@event.Extensions);
            Assert.Equal(httpRequest, @event.Extensions.HttpRequest);
            Assert.Equal(string.Empty, @event.Data);
        }

        [InlineData("default", "default")]
        [InlineData("account", "default")]
        [InlineData("account", "namespace1")]
        [InlineData("default", "namespace2")]
        [InlineData("hellowithdata", "namespace3")]
        [Theory]
        public async void CheckEventFromDefaultParameterHandler(string eventType, string eventNamespace)
        {
            // Arrange
            string eventId = Guid.NewGuid().ToString();
            string eventTime = DateTime.Now.ToString();
            var data = new { id = Guid.NewGuid() };
            IParameterHandler parameterHandler = GetDefaultParameterHandler();
            HttpRequest httpRequest = EnvironmentManager.GetHttpRequest(eventId, eventType, eventTime, eventNamespace, data);

            // Act
            (Event @event, _) = await parameterHandler.GetFunctionParameters(httpRequest);

            // Assert
            Assert.NotNull(@event);
            Assert.NotNull(@event.Extensions);
            Assert.Equal(httpRequest, @event.Extensions.HttpRequest);
            Assert.Equal(eventId, @event.EventId);
            Assert.Equal(eventNamespace, @event.EventNamespace);
            Assert.Equal(eventTime, @event.EventTime);
            Assert.Equal(eventType, @event.EventType);
            Assert.NotNull(@event.Data);
            Assert.Equal(data.id.ToString(), ((JsonElement)@event.Data).GetProperty("id").ToString());
        }

        private IParameterHandler GetDefaultParameterHandler()
        {
            IConfiguration config
                = new ConfigurationBuilder()
                .AddEnvironmentVariables()
                .Build();

            IParameterHandler parameterHandler = new DefaultParameterHandler(config);

            return parameterHandler;
        }
    }
}
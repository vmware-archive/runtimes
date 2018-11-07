using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Kubeless.WebAPI.Utils
{
    public static class VariablesUtils
    {
        public static string GetEnvVar(string environmentVariable, string defaultValue)
        {
            var variable = Environment.GetEnvironmentVariable(environmentVariable);
            return string.IsNullOrWhiteSpace(variable) ? defaultValue : variable;
        }

        public static string GetNotNullConfiguration(this IConfiguration configuration, string key)
        {
            var config = configuration[key];
            if (string.IsNullOrEmpty(config))
                throw new ArgumentNullException(key);
            else
                return config;
        }
    }
}

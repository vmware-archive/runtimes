using System.Threading.Tasks;
using Kubeless.Functions;
using Microsoft.AspNetCore.Http;

namespace Kubeless.Core.Interfaces
{
    public interface IParameterHandler
    {
        Task<(Event, Context)> GetFunctionParameters(HttpRequest request);
    }
}

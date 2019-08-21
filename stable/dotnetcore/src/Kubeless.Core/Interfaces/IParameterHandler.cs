using Kubeless.Functions;
using Microsoft.AspNetCore.Http;

namespace Kubeless.Core.Interfaces
{
    public interface IParameterHandler
    {
        (Event, Context) GetFunctionParameters(HttpRequest request);
    }
}

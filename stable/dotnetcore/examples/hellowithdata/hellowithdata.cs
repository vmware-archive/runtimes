using System;
using Kubeless.Functions;
using System.Threading.Tasks;

public class module
{
    public Task<object> handler(Event k8Event, Context k8Context)
    {
        return Task.FromResult<object>(k8Event.Data);
    }
}

using System;
using System.Threading;
using Kubeless.Functions;
using System.Threading.Tasks;

public class module
{
    public Task<object> handler(Event k8Event, Context k8Context)
    {
        int durationTime = (int)k8Event.Data;

        Thread.Sleep(durationTime);

        return Task.FromResult<object>("This is a long run!");
    }
}

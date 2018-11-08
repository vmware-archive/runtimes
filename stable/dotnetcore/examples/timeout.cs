using System;
using System.Threading;
using Kubeless.Functions;

public class module
{
    public string handler(Event k8Event, Context k8Context)
    {
        int durationTime = (int)k8Event.Data;

        Thread.Sleep(durationTime);

        return "This is a long run!";
    }
}

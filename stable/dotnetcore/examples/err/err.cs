using System;
using Kubeless.Functions;
using System.Threading.Tasks;

public class module
{
    public Task<object> handler(Event k8Event, Context k8Context)
    {
      throw new Exception("this function will always throw.");
    }
}
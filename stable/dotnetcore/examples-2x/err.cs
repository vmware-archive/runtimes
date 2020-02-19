using System;
using Kubeless.Functions;

public class module
{
    public int handler(Event k8Event, Context k8Context)
    {
      throw new Exception("this function will always throw.");
    }
}
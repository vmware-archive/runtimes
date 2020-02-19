using System;
using Kubeless.Functions;

namespace mynamespace.othernamespace.anothernamespace
{
    public class module
    {
        public string handler(Event k8Event, Context k8Context)
        {
            return "hello world";
        }
    }
}
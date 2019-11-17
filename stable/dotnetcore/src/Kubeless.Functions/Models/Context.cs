namespace Kubeless.Functions
{
    public class Context
    {
        public string ModuleName { get; }
        public string FunctionName { get; }
        public string FunctionPort { get; }
        public string Timeout { get; }
        public string Runtime { get; }
        public string MemoryLimit { get; }

        public Context(string moduleName, string functionName, string functionPort, string timeout, string runtime, string memoryLimit)
        {
            ModuleName = moduleName;
            FunctionName = functionName;
            FunctionPort = functionPort;
            Timeout = timeout;
            Runtime = runtime;
            MemoryLimit = memoryLimit;
        }

        public Context() { }
    }
}

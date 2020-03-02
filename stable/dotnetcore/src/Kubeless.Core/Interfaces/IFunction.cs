namespace Kubeless.Core.Interfaces
{
    public interface IFunction
    {
        string ModuleName { get; }
        string FunctionHandler { get; }
        string AssemblyName { get; }
    }
}

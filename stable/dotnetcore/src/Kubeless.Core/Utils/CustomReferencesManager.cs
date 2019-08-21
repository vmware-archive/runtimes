using System.Collections.Generic;
using System.IO;

namespace Kubeless.Core.Utils
{
    public class CustomReferencesManager
    {
        public IEnumerable<string> GetReferences(string referencesPath)
        {
            if (Directory.Exists(referencesPath))
                return Directory
                    .EnumerateFiles(referencesPath, "*.dll", SearchOption.AllDirectories)
                    .ApplyFilterForNetStandard();
            else
                return new List<string>();
        }
    }
}

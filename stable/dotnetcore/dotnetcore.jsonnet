{
  ID: "dotnetcore",
  compiled: true,
  versions: [
    {
      name: "dotnetcore2.0",
      version: "2.0",
      runtimeImage: "allantargino/kubeless-dotnetcore@sha256:1699b07d9fc0276ddfecc2f823f272d96fd58bbab82d7e67f2fd4982a95aeadc",
      initImage: "allantargino/aspnetcore-build@sha256:0d60f845ff6c9c019362a68b87b3920f3eb2d32f847f2d75e4d190cc0ce1d81c"
    }
  ],
  depName: "project.csproj",
  fileNameSuffix: ".cs"
}

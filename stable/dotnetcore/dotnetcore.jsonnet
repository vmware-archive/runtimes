{
  ID: "dotnetcore",
  versions: [
    {
      name: "dotnetcore2.0",
      version: "2.0",
      images: [{
        phase: "compilation",
        image: "allantargino/aspnetcore-build@sha256:0d60f845ff6c9c019362a68b87b3920f3eb2d32f847f2d75e4d190cc0ce1d81c",
        command: "/app/compile-function.sh $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "allantargino/kubeless-dotnetcore@sha256:1699b07d9fc0276ddfecc2f823f272d96fd58bbab82d7e67f2fd4982a95aeadc",
        env: {
          DOTNETCORE_HOME: "$KUBELESS_INSTALL_VOLUME/packages",
        },
      }],
    }
  ],
  depName: "project.csproj",
  fileNameSuffix: ".cs"
}

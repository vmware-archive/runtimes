{
  ID: "dotnetcore",
  versions: [
    {
      name: "dotnetcore2.0",
      version: "2.0",
      images: [{
        phase: "compilation",
        image: "allantargino/aspnetcore-build@sha256:36123cf0279b87c5d27d69558062678a5353cc6db238af46bd5c0e508109f659",
        command: "/app/compile-function.sh $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "allantargino/kubeless-dotnetcore@sha256:b49d38fe20b5646d96e5f1024975c5a24ff2be86331e704287897ea019b1f8aa",
        env: {
          DOTNETCORE_HOME: "$(KUBELESS_INSTALL_VOLUME)/packages",
        },
      }],
    }
  ],
  depName: "project.csproj",
  fileNameSuffix: ".cs"
}

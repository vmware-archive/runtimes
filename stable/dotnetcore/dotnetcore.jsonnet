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
          DOTNETCORE_HOME: "$(KUBELESS_INSTALL_VOLUME)/packages",
        },
      }],
    },
    {
      name: "dotnetcore2.1",
      version: "2.1",
      images: [{
        phase: "compilation",
        image: "allantargino/aspnetcore-build@sha256:36123cf0279b87c5d27d69558062678a5353cc6db238af46bd5c0e508109f659",
        command: "/app/compile-function.sh $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "allantargino/kubeless-dotnetcore@sha256:6d6c659807881e9dac7adde305867163ced5711ef77a3a76e50112bca1ba14cf",
        env: {
          DOTNETCORE_HOME: "$(KUBELESS_INSTALL_VOLUME)/packages",
        },
      }],
    },
    {
      name: "dotnetcore2.2",
      version: "2.2",
      images: [{
        phase: "compilation",
        image: "lennartquerter/kubless_compile_dotnetcore22:4761f204190ad59807b9231e096cbcb3901226cd",
        command: "/app/compile-function.sh $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "lennartquerter/kubless_runtime_dotnetcore22:4761f204190ad59807b9231e096cbcb3901226cd",
        env: {
          DOTNETCORE_HOME: "$(KUBELESS_INSTALL_VOLUME)/packages",
        },
      }],
    },
    {
      name: "dotnetcore3.1",
      version: "3.1",
      images: [{
        phase: "compilation",
        image: "lorenzoangelini3/kubeless-compile-dotnetcore31@sha256:12a85136102b9df6b09138dadd3bf77af111dc992286a0fd8ab4b03fd897fcc5",
        command: "/app/compile-function.sh $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "lorenzoangelini3/kubeless-runtime-dotnetcore31@sha256:1d5b22f51a5584689e8ed0d31e428d50bef12cd48e31b7447d20df5372c72ba7",
        env: {
          DOTNETCORE_HOME: "$(KUBELESS_INSTALL_VOLUME)/packages",
        },
      }],
    },
  ],
  depName: "project.csproj",
  fileNameSuffix: ".cs"
}

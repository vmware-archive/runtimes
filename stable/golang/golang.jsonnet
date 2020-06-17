{
  ID: "go",
  versions: [
    {
      name: "go1.13",
      version: "1.13",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.13@sha256:7cdebecd772639c2238e6414101195cb8634c8eee73a6b473b7e39f3e094eb7c",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:55759228714d7080b3dd858e56530d4e1f539d071906e88d88b454ee3b3c9b16"
      }],
    },
    {
      name: "go1.14",
      version: "1.14",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.14@sha256:403164254efabf735e98e73b7f6f65f14333ed792798c7c3d3d9a33ca91acf7a",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:55759228714d7080b3dd858e56530d4e1f539d071906e88d88b454ee3b3c9b16"
      }],
    },
  ],
  depName: "go.mod",
  fileNameSuffix: ".go"
}

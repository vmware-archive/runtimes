{
  ID: "go",
  versions: [
    {
      name: "go1.13",
      version: "1.13",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.13@sha256:1619c58b52e9e767a83dd4269206b4554eb008352af15ca00b25db8127520b8c",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:ee496259f1bef2c338d074bfb5c14a08bb097f793a683d208a50df9f24d0d850"
      }],
    },
    {
      name: "go1.14",
      version: "1.14",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.14@sha256:b4b98c2848845447a43b50d61a386bcaa5bb34d5034a969aa404a41d71f1c439",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:ee496259f1bef2c338d074bfb5c14a08bb097f793a683d208a50df9f24d0d850"
      }],
    },
  ],
  depName: "go.mod",
  fileNameSuffix: ".go"
}

{
  ID: "go",
  versions: [
    {
      name: "go1.13",
      version: "1.13",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.13@sha256:7805af97525cf7f6c7a70ce40c1bf5af51346d34096fd3a8bd04849ea5022ca3",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:78b3789b48614034d20dbd26a66e0247d38c21cff78f86b6e4f560a827839b7f"
      }],
    },
    {
      name: "golang1.14",
      version: "1.14",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.14@sha256:7805af97525cf7f6c7a70ce40c1bf5af51346d34096fd3a8bd04849ea5022ca3",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:78b3789b48614034d20dbd26a66e0247d38c21cff78f86b6e4f560a827839b7f"
      }],
    },
  ],
  depName: "go.mod",
  fileNameSuffix: ".go"
}

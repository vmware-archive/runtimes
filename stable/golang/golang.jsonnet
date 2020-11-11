{
  ID: "go",
  versions: [
    {
      name: "go1.13",
      version: "1.13",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.13@sha256:9161934a6333ff5932ec48933efe30fc988bbbff6e13e1c4eb6f3626e70390c7",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:4048280138205d5ef2aa0dc4d169dca701e4df02d7feb42537cfd76ddef9c2b5"
      }],
    },
    {
      name: "go1.14",
      version: "1.14",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init:1.14@sha256:1aeaf270961b0e5cdb9e5119bc1c1222b75d46d9d1311854ec37b4a842241219",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:4048280138205d5ef2aa0dc4d169dca701e4df02d7feb42537cfd76ddef9c2b5"
      }],
    },
  ],
  depName: "go.mod",
  fileNameSuffix: ".go"
}

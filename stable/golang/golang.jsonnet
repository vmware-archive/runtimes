{
  ID: "go",
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:cee10536fc4dca78928f21c85462ff75ec79e3425403f9c8b233f43df074d256",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:cee10536fc4dca78928f21c85462ff75ec79e3425403f9c8b233f43df074d256",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:27bf0dfd1633e50c02f0fe8aed079571a4001126206aaa89ee024c26b94999fe"
      }],
    },
    {
      name: "go1.11",
      version: "1.11",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:b364af8edb70a0d92ef992b667f56a5df159181310ec2d5e33a07da15ca88902",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:b364af8edb70a0d92ef992b667f56a5df159181310ec2d5e33a07da15ca88902",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:27bf0dfd1633e50c02f0fe8aed079571a4001126206aaa89ee024c26b94999fe"
      }],
    },
    {
      name: "go1.12",
      version: "1.12",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:67b9d5cbd93500dfe8f15de8b7846069180a2a50d2fdb63b42330de32cfe17ab",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:67b9d5cbd93500dfe8f15de8b7846069180a2a50d2fdb63b42330de32cfe17ab",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:27bf0dfd1633e50c02f0fe8aed079571a4001126206aaa89ee024c26b94999fe"
      }],
    },
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

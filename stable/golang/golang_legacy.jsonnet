{
  ID: "go",
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:163f46d781301490436db334ed34845a08f9b5c39746932a5d93b4c11c4ad43b",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:163f46d781301490436db334ed34845a08f9b5c39746932a5d93b4c11c4ad43b",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:d2c5cfd3b7b31276d02ca22ddc7961aebe6050add4482b695ae3a686c76bad35"
      }],
    },
    {
      name: "go1.11",
      version: "1.11",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:e3592e7605608b620bc8f313c9b1e0e3ae4795bab8bdf1c01d53dd992ef316cd",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:e3592e7605608b620bc8f313c9b1e0e3ae4795bab8bdf1c01d53dd992ef316cd",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:d2c5cfd3b7b31276d02ca22ddc7961aebe6050add4482b695ae3a686c76bad35"
      }],
    },
    {
      name: "go1.12",
      version: "1.12",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:a669748f121755966e884455c9b6a978f1b92dca85f5bf53c1cf0aff76acb6b6",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:a669748f121755966e884455c9b6a978f1b92dca85f5bf53c1cf0aff76acb6b6",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:d2c5cfd3b7b31276d02ca22ddc7961aebe6050add4482b695ae3a686c76bad35"
      }],
    },
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

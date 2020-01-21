{
  ID: "go",
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:30f43f2c2868d0ed8b5610390d399348946f0e4e2c442fbcdc1d0bfd3be0415b",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:30f43f2c2868d0ed8b5610390d399348946f0e4e2c442fbcdc1d0bfd3be0415b",
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
        image: "kubeless/go-init@sha256:00dc3d221f87d6b295cdadeebf34d2df55bce6a061fc75836b4ed7ac29dee3dd",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:00dc3d221f87d6b295cdadeebf34d2df55bce6a061fc75836b4ed7ac29dee3dd",
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
        image: "kubeless/go-init@sha256:e7ef630e301c64f29d72ce6a04073132060ff93d92b29cae29ffbaa3c7e9761d",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:e7ef630e301c64f29d72ce6a04073132060ff93d92b29cae29ffbaa3c7e9761d",
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

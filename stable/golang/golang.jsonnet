{
  ID: "go",
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:03079f4a240bc4eea124327bce22c5ae136a8883b5c047584d923e47f69bd93b",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:03079f4a240bc4eea124327bce22c5ae136a8883b5c047584d923e47f69bd93b",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:b29724e212a0763db16991f678d1457edb1f6ea4e846c8cbb625c2c4c3308e0f"
      }],
    },
    {
      name: "go1.11",
      version: "1.11",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:f30338225a39d3eec0ba246bd8c67b1919fa9c1c382d43eb96eebeae1aa55be9",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:f30338225a39d3eec0ba246bd8c67b1919fa9c1c382d43eb96eebeae1aa55be9",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:b29724e212a0763db16991f678d1457edb1f6ea4e846c8cbb625c2c4c3308e0f"
      }],
    },
    {
      name: "go1.12",
      version: "1.12",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:44e442f8b7ac30701bd5233efc1a4d9c2e4e79c5d4c3d09c49399f00793852af",
        command: "/compile-function.sh",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:44e442f8b7ac30701bd5233efc1a4d9c2e4e79c5d4c3d09c49399f00793852af",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1",
        env: {
          GOCACHE: "$(KUBELESS_INSTALL_VOLUME)/.cache",
        },
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:b29724e212a0763db16991f678d1457edb1f6ea4e846c8cbb625c2c4c3308e0f"
      }],
    },
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

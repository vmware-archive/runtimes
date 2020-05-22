{
  ID: "go",
  versions: [
    {
      name: "go1.13",
      version: "1.13",
      images: [{
        phase: "compilation",
        image: "thiagoquintoandar/go-init:1.14@sha256:84b80f719b67d5b85c3497629390c203451bb6d21490e4f91a53d7e82913e5e7",
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
      name: "go1.14",
      version: "1.14",
      images: [{
        phase: "compilation",
        image: "thiagoquintoandar/go-init:1.14@sha256:c8cf42ed7c4bcecafa03949415e44263899fdf609f483c6a6b833390d3fc04ac",
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

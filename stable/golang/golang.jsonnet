{
  ID: "go",
  compiled: true,
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:71a073429befdca59090a65966b7f4b5f732914685a1370b6660cf261fd6b950",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:71a073429befdca59090a65966b7f4b5f732914685a1370b6660cf261fd6b950",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:e2fd49f09b6ff8c9bac6f1592b3119ea74237c47e2955a003983e08524cb3ae5"
      }],
    }
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

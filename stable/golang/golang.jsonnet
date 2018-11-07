{
  ID: "go",
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      images: [{
        phase: "compilation",
        image: "kubeless/go-init@sha256:88104a60bcd4c67fd6aa92fffa46062396c08bc2632529ee435517e7628a2f95",
        command: "/compile-function.sh"
       }, {
        phase: "installation",
        image: "kubeless/go-init@sha256:88104a60bcd4c67fd6aa92fffa46062396c08bc2632529ee435517e7628a2f95",
        command: "cd $GOPATH/src/kubeless && dep ensure > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "kubeless/go@sha256:f5d449f830ac8727c0b9c05e458b6dd0a0822743cb19a87343e0fd00b041eea9"
      }],
    }
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

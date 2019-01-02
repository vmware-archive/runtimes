{
  ID: "vertx",
  versions: [
    {
      name: "vertx1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "oscardovao/vertx-init@sha256:6665629b3239eb1d81654381b02c3dd4b87ddb0a1b0b49acc165f0ff53264e0b",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "oscardovao/vertx@sha256:96243e5937a875422d6165e59f1fdb350f1a6d5befbd89f26968abea4345ade1"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

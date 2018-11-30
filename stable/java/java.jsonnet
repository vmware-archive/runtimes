{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:36cc37836437aaa5ac82f49ba20781d45bd5efcd9e2d022fcaae487a058572c2",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:2dbc44c0e2467a27558776edb2aed85055361e2f0b74443800851ee658576a88"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

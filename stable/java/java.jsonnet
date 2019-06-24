{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:29a5e01801bb066c9b23d4da8bb3024b79b15a8541ceb44f2c65e3bd94766edd",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:fafffa963732c860c08728da99b1ec8c3b722840ac29722e69798124fef63054"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

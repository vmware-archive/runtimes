{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:cae4bd703d08eb98ccdeba0675420d2f5a3a265bb9c2dcb97f0bea3c63740c1e",
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

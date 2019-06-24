{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:1bf287669347a879f8c71f06426cfc8402f17439b2793259a06ef6dfd051b5ee",
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

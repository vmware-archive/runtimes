{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:a14d846bfe53f359f706a260b95f0a9a755883b053dbd17b724e7a3cdff5bae6",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:d2a59e50e8181174ad3c6096cd5d3ce82f46b7e22a6f3a109b0816787e7190d9"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

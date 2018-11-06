{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:bd68a7dcfa30f3b6350c0b930632115c1865917dfa9c2992cd48dc3159e663e8",
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

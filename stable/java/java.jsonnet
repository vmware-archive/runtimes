{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:5f2e7227998799469c2b7ec6102aee5fbef715465c97448f1bdc91c4160d0baf",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:68754101add18772fd2275ce7a21e05c7e3f495eb745c75cc2a38a9e003b81db"
      }],
    },
    {
      name: "java11",
      version: "11",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:1f36ed53e882a15388dd5d437d8f659f0bad38810669b195e0446ee595498c75",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:e336adef7566a466dd5461213a95e11acc0ef7a23dac34631216b8546b38567d"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

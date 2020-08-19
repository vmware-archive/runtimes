{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:c6364edc993d222482b0a1608d32dd744b8f11a73f3cd7395dee611ae143c8b8",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:bfdfcbf7468fdb47baf78f9b3a7372ec5c7d2598cc44bb828e07a2366ee97287"
      }],
    },
    {
      name: "java11",
      version: "11",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:23390ab52914e32bc344f6f364ba711debb76b93a4cebd0b99a7d274ad12e1b0",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:e4cfa243f21e498e2d291174a785f8f70ca87feeb40641d09d6ef9260b9bc999"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

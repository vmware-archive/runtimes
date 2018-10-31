{
  ID: "java",
  compiled: true,
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      runtimeImage: "kubeless/java@sha256:debf9502545f4c0e955eb60fabb45748c5d98ed9365c4a508c07f38fc7fefaac",
      initImage: "kubeless/java-init@sha256:7e5e4376d3ab76c336d4830c9ed1b7f9407415feca49b8c2bf013e279256878f"
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

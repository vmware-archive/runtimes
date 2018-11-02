{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:c760de0fa902afc089360783010039b67c3c4695ef65de798ccaf3d69b5bc559",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:debf9502545f4c0e955eb60fabb45748c5d98ed9365c4a508c07f38fc7fefaac"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

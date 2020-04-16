{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:e8e7b55b79240f315f104604ec0685dbb1b584664772e1f0fe78c7b6369159fe",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:f8f2c72b0c6218f25eef762aa9e8957ea2b8f448bd4b54fbb7acbb0ab64c1b0f"
      }],
    },
    {
      name: "java11",
      version: "11",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:971cb482b47d644e28d3d9ceaa3a20bb0f914f2efaee0348f189840466cce663",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:b983f701e1796f3d9a3455f8f08c057bae493835364b08b5cdfac582a2b91d70"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

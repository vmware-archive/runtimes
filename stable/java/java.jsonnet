{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:7e49a9c91e0fd7d0ffd0e184116769e56705cc1d6d39b11ced8ec94dbdc77543",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:fafffa963732c860c08728da99b1ec8c3b722840ac29722e69798124fef63054"
      }],
    },
    {
      name: "java11",
      version: "11",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:b7a8ae3c17b7cefaa28364348d2f504a02c936d38aee57f46b61f3745c784c17",
        command: "/compile-function.sh"
       }, {
        phase: "runtime",
        image: "kubeless/java@sha256:b04e8e1f4a1acb8a94778320df8fd13aaf1eed22034007bf6d9109e55a4aa0c8"
      }],
    }
  ],
  depName: "pom.xml",
  fileNameSuffix: ".java"
}

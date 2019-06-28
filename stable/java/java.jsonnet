{
  ID: "java",
  versions: [
    {
      name: "java1.8",
      version: "1.8",
      images: [{
        phase: "compilation",
        image: "kubeless/java-init@sha256:6f6006a563e83d6999a44ca2740b5e6c5f0a0ec377e83ca2924dff20eaf37107",
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
        image: "kubeless/java-init@sha256:625ffabbc687ae6cd3e6002bc7f31e680f43dfedb6d005b9d5772b86bb130e4f",
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

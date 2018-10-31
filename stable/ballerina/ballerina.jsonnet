{
  ID: "ballerina",
  compiled: true,
  versions: [
    {
      name: "ballerina0.981.0",
      version: "0.981.0",
      images: [{
        phase: "compilation",
        image: "ballerina/kubeless-ballerina-init@sha256:a04ca9d289c62397d0b493876f6a9ff4cc425563a47aa7e037c3b850b8ceb3e8",
        command: "/compile-function.sh $KUBELESS_FUNC_NAME"
       }, {
        phase: "runtime",
        image: "ballerina/kubeless-ballerina@sha256:a025841010cfdf8136396efef31d4155283770d331ded6a9003e6e55f02db2e5"
      }],
      runtimeImage: "ballerina/kubeless-ballerina@sha256:a025841010cfdf8136396efef31d4155283770d331ded6a9003e6e55f02db2e5",
      initImage: "ballerina/kubeless-ballerina-init@sha256:a04ca9d289c62397d0b493876f6a9ff4cc425563a47aa7e037c3b850b8ceb3e8"
    }
  ],
  depName: "",
  fileNameSuffix: ".bal"
}
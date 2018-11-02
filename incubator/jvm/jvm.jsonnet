{
  ID: 'jvm',
  versions:
   [ { name: 'jvm1.8',
       version: '1.8',
       images: [{
        phase: "compilation",
        image: "caraboides/jvm-init@sha256:e57dbf3f56570a196d68bce1c0695102b2dbe3ae2ca6d1c704476a7a11542f1d",
        command: "mv /kubeless/* /kubeless/payload.jar && cp /opt/*.jar /kubeless/ > /dev/termination-log 2>&1"
       }, {
        phase: "runtime",
        image: "caraboides/jvm@sha256:2870c4f48df4feb2ee7478a152b44840d781d4b1380ad3fa44b3c7ff314faded"
       }],
      },
   ],
  depName: '',
  fileNameSuffix: '.jar'
}

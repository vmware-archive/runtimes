{
  ID: 'nodejs_distroless',
  versions:
    [ { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:424add88dc2a7fdc45012593159794d59a6ea4aafadfffb632d21ae53b1d262b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "henrike42/kubeless/runtimes/nodejs/distroless:0.0.2"
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

{
  ID: 'nodejs',
  compiled: false,
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:2ef1993578ef9e92fc32f9c978cd19c0f43b23d3205bafa8fb9a91d37c66466e",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:2ef1993578ef9e92fc32f9c978cd19c0f43b23d3205bafa8fb9a91d37c66466e"
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:424add88dc2a7fdc45012593159794d59a6ea4aafadfffb632d21ae53b1d262b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:424add88dc2a7fdc45012593159794d59a6ea4aafadfffb632d21ae53b1d262b"
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

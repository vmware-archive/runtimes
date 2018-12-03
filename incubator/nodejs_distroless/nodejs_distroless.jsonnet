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
        image: "kubeless/nodejs-distroless@sha256:1fa0469c5520f4e08d89b1fafd2cacf03f098b96ea04997fa52bb9ef2a180fb3",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

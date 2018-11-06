{
  ID: 'nodejs_ce',
  versions:
    [ { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:424add88dc2a7fdc45012593159794d59a6ea4aafadfffb632d21ae53b1d262b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "andresmgot/nodejs-ce@sha256:708c265d22a8a1599e05da844d26bc63e2f66f859ffecd2fcb541ecac9c66780",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

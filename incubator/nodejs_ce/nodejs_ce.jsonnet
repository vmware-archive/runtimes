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
        image: "andresmgot/nodejs-ce@sha256:0c27a5e9ddd22f4f9ea50be0660c9595e0a98783d5201bf223a338de57b2a8a5",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

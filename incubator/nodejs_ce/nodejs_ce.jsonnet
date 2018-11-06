{
  ID: 'nodejsCE',
  versions:
    [ { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:456d98f6f15588b21f5110facf1cc203065840d4c227afa61d17c6c1fa98b3b6",
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

{
  ID: 'nodejs',
  versions:
    [ { name: 'node10',
       version: '10',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:09dcc6a644a2e28fa13988ff6e3755627cb83ac0e65f9a89c8c2a13c3560493b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:09dcc6a644a2e28fa13988ff6e3755627cb83ac0e65f9a89c8c2a13c3560493b",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node12',
       version: '12',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:90fd5aed17af289489b7ae32233d268dd5cc4c9ebc6b934910fd5f1bbdb7cdd1",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:90fd5aed17af289489b7ae32233d268dd5cc4c9ebc6b934910fd5f1bbdb7cdd1",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
     { name: 'node14',
       version: '14',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:f3645b5e8417e5bcc905446e1fac8a7d565be74eeba4fd80c2487c5d43a32a7b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:f3645b5e8417e5bcc905446e1fac8a7d565be74eeba4fd80c2487c5d43a32a7b",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

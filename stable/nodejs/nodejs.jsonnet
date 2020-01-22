{
  ID: 'nodejs',
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:d36e13e876d0d92cbf4b9a62e181b27bfdaed5b9ec0b7c46759f9e11fce68c6e",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:d36e13e876d0d92cbf4b9a62e181b27bfdaed5b9ec0b7c46759f9e11fce68c6e",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:40df41562637802e34129f31e66f6e0ab388da6d8a33c9849bb9ea652d44dc3d",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:40df41562637802e34129f31e66f6e0ab388da6d8a33c9849bb9ea652d44dc3d",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
     { name: 'node10',
       version: '10',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:74f8428ba9e98b6849ab34d2d1b5c38381b1de471090f7cc3dc9f72322f8c921",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:74f8428ba9e98b6849ab34d2d1b5c38381b1de471090f7cc3dc9f72322f8c921",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node12',
       version: '12',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:2a0824cba4486dcc0508b6424b29878ccf57057023c391c1a30ddb09fa9b8503",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:2a0824cba4486dcc0508b6424b29878ccf57057023c391c1a30ddb09fa9b8503",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

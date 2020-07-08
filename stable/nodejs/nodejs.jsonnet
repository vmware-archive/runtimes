{
  ID: 'nodejs',
  versions:
    [ { name: 'node10',
       version: '10',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:48818c97a0d44e9a3fbf3508645eb9cdb5b5abc173d58bb93e555b5a396c7775",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:48818c97a0d44e9a3fbf3508645eb9cdb5b5abc173d58bb93e555b5a396c7775",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node12',
       version: '12',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:6ec17ba0ce3fd706085b2fc81c1ba3dd6a1cffdc4484df483376a1a9c10e50f8",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:6ec17ba0ce3fd706085b2fc81c1ba3dd6a1cffdc4484df483376a1a9c10e50f8",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
     { name: 'node14',
       version: '14',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:12e077fbb4b4dbb38752be37204d782d1a33e6db0c88d52082d87e0cd59e2b4e",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:12e077fbb4b4dbb38752be37204d782d1a33e6db0c88d52082d87e0cd59e2b4e",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

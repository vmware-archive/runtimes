{
  ID: 'nodejs',
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:e72370621155aafe904e38e2c382dd3cd5e4058c7ad8baf9bda0d163c001399e",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:e72370621155aafe904e38e2c382dd3cd5e4058c7ad8baf9bda0d163c001399e",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:f4b210a7c45730fec888a8ff9ab853405536a361c2526306659c68487528892b",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:f4b210a7c45730fec888a8ff9ab853405536a361c2526306659c68487528892b",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

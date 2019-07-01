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
     { name: 'node10',
       version: '10',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:9594e9d601cfe3868b54cccf1cd8763b2430493fed3e06d7dc128a69b263dfaf",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:9594e9d601cfe3868b54cccf1cd8763b2430493fed3e06d7dc128a69b263dfaf",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node12',
       version: '12',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:1c45cda56384adc7deae9bf99e221b8e159ec25980c05b947939096bf91800e6",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:1c45cda56384adc7deae9bf99e221b8e159ec25980c05b947939096bf91800e6",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

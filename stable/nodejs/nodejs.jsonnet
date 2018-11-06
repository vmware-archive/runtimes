{
  ID: 'nodejs',
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:4d8f5d6ad51676e8faffc0da6fabe8e12cf8cf34ae0ce8e94ee4e510f9876d2e",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:4d8f5d6ad51676e8faffc0da6fabe8e12cf8cf34ae0ce8e94ee4e510f9876d2e",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:5c3c21cf29231f25a0d7d2669c6f18c686894bf44e975fcbbbb420c6d045f7e7",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:5c3c21cf29231f25a0d7d2669c6f18c686894bf44e975fcbbbb420c6d045f7e7",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

{
  ID: 'nodejs',
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:28fe2edc427e1deefb9d2cb12878d98e64fd14dc0299f4bf009f9ce26bd8b14a",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:28fe2edc427e1deefb9d2cb12878d98e64fd14dc0299f4bf009f9ce26bd8b14a",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:1c57908576b80142b070018091d2fd2d6446428de94d331aa0483ddc5e6e002c",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:1c57908576b80142b070018091d2fd2d6446428de94d331aa0483ddc5e6e002c",
        env: {
          NODE_PATH: "$(KUBELESS_INSTALL_VOLUME)/node_modules",
        },
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

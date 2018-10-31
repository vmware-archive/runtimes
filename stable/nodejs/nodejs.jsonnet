{
  ID: 'nodejs',
  compiled: false,
  versions:
    [ { name: 'node6',
       version: '6',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:456d98f6f15588b21f5110facf1cc203065840d4c227afa61d17c6c1fa98b3b6",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:456d98f6f15588b21f5110facf1cc203065840d4c227afa61d17c6c1fa98b3b6"
       }],
      },
     { name: 'node8',
       version: '8',
       images: [{
        phase: "installation",
        image: "kubeless/nodejs@sha256:e9e4fdf33b52ec0a9fb2aab45e1bb228a6abd013f9e0f12b505f6c93d4d68897",
        command: "/kubeless-npm-install.sh"
       }, {
        phase: "runtime",
        image: "kubeless/nodejs@sha256:e9e4fdf33b52ec0a9fb2aab45e1bb228a6abd013f9e0f12b505f6c93d4d68897"
       }],
     },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

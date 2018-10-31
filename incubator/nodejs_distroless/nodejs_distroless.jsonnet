{
  ID: 'nodejs_distroless',
  compiled: false,
  versions:
   [ { name: 'node8',
       version: '8',
       runtimeImage: 'henrike42/kubeless/runtimes/nodejs/distroless:0.0.2',
       initImage: 'node:8' },
   ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

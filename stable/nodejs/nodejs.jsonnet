{
  ID: 'nodejs',
  compiled: false,
  versions:
    [ { name: 'node6',
       version: '6',
       runtimeImage: 'kubeless/nodejs@sha256:556ff930c7a609d1ad90322d41c8b562cb42313898486fed9674fb2647e4b42f',
       initImage: 'node:6.10' },
     { name: 'node8',
       version: '8',
       runtimeImage: 'kubeless/nodejs@sha256:5c9c5e36f9845f2cf8e9e0d55993796d82e34a2b8c0f8a508c9d3c04b2041076',
       initImage: 'node:8' },
    ],
  depName: 'package.json',
  fileNameSuffix: '.js'
}

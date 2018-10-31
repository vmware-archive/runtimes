{ 
  ID: 'php',
  compiled: false,
  versions:
    [ { name: 'php72',
       version: '7.2',
       runtimeImage: 'kubeless/php@sha256:9b86066b2640bedcd88acb27f43dfaa2b338f0d74d9d91131ea781402f7ec8ec',
       initImage: 'composer:1.6' },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

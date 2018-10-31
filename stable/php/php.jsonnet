{ 
  ID: 'php',
  compiled: false,
  versions:
    [ { name: 'php72',
       version: '7.2',
       images: [{
        phase: "installation",
        image: "composer:1.6",
        command: "composer install -d $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/php@sha256:9b86066b2640bedcd88acb27f43dfaa2b338f0d74d9d91131ea781402f7ec8ec"
       }],
      },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

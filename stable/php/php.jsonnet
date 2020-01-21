{ 
  ID: 'php',
  versions:
    [ { name: 'php72',
       version: '7.2',
       images: [{
        phase: "installation",
        image: "composer:1.6",
        command: "composer install -d $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/php@sha256:a22a88fc7e0f46d185224a0179451187d6ab44b89c070807bf92a305ce416e4a"
       }],
      },
      { name: 'php73',
       version: '7.3',
       images: [{
        phase: "installation",
        image: "composer:1.6",
        command: "composer install -d $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/php@sha256:eec60c68440ca2e09dbac63718916ffbaa68e2d123a3faaca1bca2d7646f250f"
       }],
      },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

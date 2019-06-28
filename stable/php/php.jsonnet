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
        image: "kubeless/php@sha256:981e2bb6b6662176992427d55da76258ecadb0dc9ef03d1feed66250c828014e"
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
        image: "kubeless/php@sha256:8f7f8aa9980a14126d9b9e8b3742258efd2591b0e152b4d65e0d7b5faf61a041"
       }],
      },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

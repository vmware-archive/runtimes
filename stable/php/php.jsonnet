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
        image: "kubeless/php@sha256:b7319492ad1f84de4b1b2c8b522b12e7807f14ddb05fa8ad59f648617b8396f9"
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
        image: "kubeless/php@sha256:ed77d3c00748bf7b9a4586ca59aa151ec27019fe33537c7d10a84d68fb45fbf5"
       }],
      },
      {
       name: 'php74',
       version: '7.4',
       images: [{
        phase: "installation",
        image: "composer:1.6",
        command: "composer install -d $KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/php@sha256:497403402a9337969c9e24862894ac32422bf2231ac717f7e32705d36138f5a6"
       }],
      },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

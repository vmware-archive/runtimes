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
        image: "kubeless/php@sha256:19730050fca38f2efc5a7bbe94b3e8c76051ad3987dfb38de6d71a24ddea4d91"
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
        image: "kubeless/php@sha256:2ec4bc612c24a6967719581f91157160b43391c0bce57f9ecf84783ef088e9dd"
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
        image: "kubeless/php@sha256:0ee27762d02064fb3a6fc50fb420891e570bbcc2293135dc90320b42f73f64f5"
       }],
      },
    ],
  depName: 'composer.json',
  fileNameSuffix: '.php',
}

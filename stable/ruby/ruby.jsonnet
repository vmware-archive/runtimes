{
  ID: 'ruby',
  versions:
   [ { name: 'ruby23',
       version: '2.3',
       images: [{
        phase: "installation",
        image: "bitnami/ruby:2.3",
        command: "bundle install --gemfile=$KUBELESS_DEPS_FILE --path=$KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/ruby@sha256:67870b57adebc4dc749a8a19795da801da2d05fc6e8324168ac1b227bb7c77f7",
        env: {
          GEM_HOME: "$KUBELESS_INSTALL_VOLUME/ruby/2.3.0",
        },
       }],
     },
     { name: 'ruby24',
       version: '2.4',
       images: [{
        phase: "installation",
        image: "bitnami/ruby:2.4",
        command: "bundle install --gemfile=$KUBELESS_DEPS_FILE --path=$KUBELESS_INSTALL_VOLUME"
       }, {
        phase: "runtime",
        image: "kubeless/ruby@sha256:aaa9c7f3dfd4f866a527c04171c32dae2efa420d770a6af9c517771137ab4011",
        env: {
          GEM_HOME: "$KUBELESS_INSTALL_VOLUME/ruby/2.4.0",
        },
       }],
     },
     { name: 'ruby25',
       version: '2.5',
       images: [{
         phase: "installation",
         image: "bitnami/ruby:2.5",
         command: "bundle install --gemfile=$KUBELESS_DEPS_FILE --path=$KUBELESS_INSTALL_VOLUME"
        }, {
         phase: "runtime",
         image: "kubeless/ruby@sha256:577e35724996ba340ff0a18366bce99586b0be58e4d27fa3e8038f977caf1559",
         env: {
          GEM_HOME: "$KUBELESS_INSTALL_VOLUME/ruby/2.5.0",
         },
       }],
     },
   ],
  depName: 'Gemfile',
  fileNameSuffix: '.rb',
}

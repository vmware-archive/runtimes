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
          GEM_HOME: "$(KUBELESS_INSTALL_VOLUME)/ruby/2.3.0",
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
        image: "kubeless/ruby@sha256:f56ec50fafee09ae0ced9c8393b6874dc5072e4786c62d52b62b3f395643b423",
        env: {
          GEM_HOME: "$(KUBELESS_INSTALL_VOLUME)/ruby/2.4.0",
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
         image: "kubeless/ruby@sha256:9a1b51da87617024ef33fc131fe673d35fe2600f06137e40301d7a4552669c7b",
         env: {
          GEM_HOME: "$(KUBELESS_INSTALL_VOLUME)/ruby/2.5.0",
         },
       }],
     },
     { name: 'ruby26',
       version: '2.6',
       images: [{
         phase: "installation",
         image: "bitnami/ruby:2.6",
         command: "bundle install --gemfile=$KUBELESS_DEPS_FILE --path=$KUBELESS_INSTALL_VOLUME"
        }, {
         phase: "runtime",
         image: "kubeless/ruby@sha256:e93ec41f43392cc1aaf6763f484aa66850b852c4a8d6841afbe8cb72aab7d810",
         env: {
          GEM_HOME: "$(KUBELESS_INSTALL_VOLUME)/ruby/2.6.0",
         },
       }],
     },
   ],
  depName: 'Gemfile',
  fileNameSuffix: '.rb',
}

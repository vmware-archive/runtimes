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
        image: "kubeless/ruby@sha256:7bb4c6adb46b31a851ee8940dbffe7619beee09e9d09ef489cebe9ba0c5d8ed2",
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
         image: "kubeless/ruby@sha256:3a0ede85a3a0735fc826889d45a67251729878b2d3816101d9530b9b655cc622",
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
         image: "kubeless/ruby@sha256:6a79d335bec224d820f149a6eb293e2bbab333ad63581e747ec644fd1af19c61",
         env: {
          GEM_HOME: "$(KUBELESS_INSTALL_VOLUME)/ruby/2.6.0",
         },
       }],
     },
   ],
  depName: 'Gemfile',
  fileNameSuffix: '.rb',
}

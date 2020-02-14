{
  ID: "python",
  versions: [
    {
      name: "python27",
      version: "2.7",
      images: [{
        phase: "installation",
        image: "python:2.7",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:255b019e73e545782f29309609342b16b41a7a1e257be1bab912bd70f8afcd15",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python2.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
    {
      name: "python34",
      version: "3.4",
      images: [{
        phase: "installation",
        image: "python:3.4",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:55e1169c69df25960dd4434566c72a4c6da8e43a7abd8e3d3f5638a6c186e9fe",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.4/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
    {
      name: "python36",
      version: "3.6",
      images: [{
        phase: "installation",
        image: "python:3.6",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:63dc8e71d6e6f39561121763c23640373ee00eecfa630db1c01edf247c2204d9",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.6/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
    {
      name: "python37",
      version: "3.7",
      images: [{
        phase: "installation",
        image: "python:3.7",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:76a32b0f4e11f02cd9e51147f4c3fed870c1ee2c9463167e9ef0e6856de99794",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

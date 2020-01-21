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
        image: "kubeless/python@sha256:7630749ee027e873b24468fec066df6a7e7f3fd6a62695405189821b7114d1e1",
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
        image: "kubeless/python@sha256:d85ce9e4d54f9db4b911c3d92f4acaef149ac7e9975823107a7118bc82d80e5c",
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
        image: "kubeless/python@sha256:f65ebe571a8e657049ec75408df6f8538ffe49037418e45b611d07243612b1fd",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

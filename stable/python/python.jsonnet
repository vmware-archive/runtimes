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
        image: "kubeless/python@sha256:d9123341d665eb7a3d01fc09702d2e4ca55fa3b5803c19b013a5cdd3bd014a0d",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python2.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
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
        image: "kubeless/python@sha256:fc83007cea11b7876b75f81e4a12a246a4dd222c99c70f32c3be6b9a2471bce6",
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
        image: "kubeless/python@sha256:33aecef513c462d8cab3f18a4045be5fa4f8ca4617ec015ce40abe04a35ac6a0",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

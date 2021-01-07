{
  ID: "python",
  versions: [
    {
      name: "python36",
      version: "3.6",
      images: [{
        phase: "installation",
        image: "python:3.6",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:7e5b40d9109508c9600f3346492913f918d6b2bdb70da0d50dae1cb6c313dbcf",
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
        image: "kubeless/python@sha256:da554547652c1bea35a0e97045861395456e642e8290c781def79cbd6dad0a96",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.7/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
    {
      name: "python38",
      version: "3.8",
      images: [{
        phase: "installation",
        image: "python:3.8",
        command: "pip install --prefix=$KUBELESS_INSTALL_VOLUME -r $KUBELESS_DEPS_FILE"
      }, {
        phase: "runtime",
        image: "kubeless/python@sha256:536eb97fda81d6e52bd947f771192077aa7b4f529fd0ca30e47561f94741963d",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.8/site-packages:$(KUBELESS_INSTALL_VOLUME)",
        },
      }],
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

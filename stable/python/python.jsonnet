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
        image: "kubeless/python@sha256:34332f4530508a810f491838a924c36ceac0ec7cab487520e2db2b037800ecda",
        env: {
          PYTHONPATH: "$KUBELESS_INSTALL_VOLUME/lib/python2.7/site-packages",
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
        image: "kubeless/python@sha256:5c93a60b83dba9324ad8358e66952232746ef9d477266d6a199617d7344c2053",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.4/site-packages",
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
        image: "kubeless/python@sha256:8c49bfa1c6aa5fbcd0f7d99d97280c161247fc94c06d26c04e39ac341c3f75e5",
        env: {
          PYTHONPATH: "$(KUBELESS_INSTALL_VOLUME)/lib/python3.6/site-packages",
        },
      }],
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

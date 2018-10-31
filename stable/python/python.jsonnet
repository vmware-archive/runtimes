{
  ID: "python",
  compiled: false,
  versions: [
    {
      name: "python27",
      version: "2.7",
      runtimeImage: "kubeless/python@sha256:34332f4530508a810f491838a924c36ceac0ec7cab487520e2db2b037800ecda",
      initImage: "python2.7",
    },
    {
      name: "python34",
      version: "3.4",
      runtimeImage: "kubeless/python@sha256:5c93a60b83dba9324ad8358e66952232746ef9d477266d6a199617d7344c2053",
      initImage: "python3.4",
    },
    {
      name: "python36",
      version: "3.6",
      runtimeImage: "kubeless/python@sha256:8c49bfa1c6aa5fbcd0f7d99d97280c161247fc94c06d26c04e39ac341c3f75e5",
      initImage: "python3.6",
    },
  ],
  depName: "requirements.txt",
  fileNameSuffix: ".py",
}

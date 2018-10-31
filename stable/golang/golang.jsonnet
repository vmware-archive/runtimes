{
  ID: "go",
  compiled: true,
  versions: [
    {
      name: "go1.10",
      version: "1.10",
      runtimeImage: "kubeless/go@sha256:e2fd49f09b6ff8c9bac6f1592b3119ea74237c47e2955a003983e08524cb3ae5",
      initImage: "kubeless/go-init@sha256:983b3f06452321a2299588966817e724d1a9c24be76cf1b12c14843efcdff502"
    }
  ],
  depName: "Gopkg.toml",
  fileNameSuffix: ".go"
}

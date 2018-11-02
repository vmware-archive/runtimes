# Contributing Guidelines

The Kubeless runtimes project accepts contributions via GitHub pull requests. This document outlines the process to help get your contribution accepted.

### Reporting a Bug in Kubeless

This repository is used by runtime developers for maintaining the official runtimes for Kubeless. If your issue is in the Kubeless tool itself, please use the issue tracker in the [kubeless/kubeless](https://github.com/kubeless/kubeless) repository.

## How to Contribute a Runtime

1. Fork this repository, develop and test your Runtime. To see specific details of how to create and test a runtime check the [developer guide](DEVELOPER_GUIDE.md).
1. Choose the correct folder for your runtime based on the information in the [Repository Structure](README.md#repository-structure) section
1. Submit a pull request.

### Technical requirements

- Must pass end to end tests (set in the CI)
- Images should not have any major security vulnerabilities
- Detailed requirements can be found [here](DEVELOPER_GUIDE.md#runtime-image-requirements)

### Documentation requirements

- Must include an in-depth `README.md`, including:
  - Short description of the runtime
  - Any prerequisites or requirements

### Merge approval and release process

A Kubeless maintainer will review the submission, and start a validation job in the CI to verify the technical requirements of the runtime. A maintainer may add "LGTM" (Looks Good To Me) or an equivalent comment to indicate that a PR is acceptable. Any change requires at least one LGTM. No pull requests can be merged until at least one maintainer signs off with an LGTM.

Once the runtime has been merged, changes in the runtime images will be shipped by default in the next release of Kubeless.

## Support Channels

Whether you are a user or contributor, official support channels include:

- GitHub issues: https://github.com/kubeless/runtimes/issues
- Slack: Kubeless - #kubeless room in the [Kubernetes Slack](http://slack.kubernetes.io/)

Before opening a new issue or submitting a new pull request, it's helpful to search the project - it's likely that another user has already reported the issue you're facing, or it's a known issue that we're already aware of.

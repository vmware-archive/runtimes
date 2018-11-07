# Kubeless Runtimes

Use this repository to submit official Runtimes for Kubeless. Runtimes are the different languages that can be used to run Kubeless functions. For more information about installing and using Kubeless, see its [documentation](https://kubeless.io/docs/). To get a quick introduction to the available runtimes see this [document](https://kubeless.io/docs/runtimes).

# Where to find us

For general Kubeless or runtime discussions join the [Kubeless (#kubeless) channel in the Kubernetes Slack](https://kubernetes.slack.com/messages/kubeless).

For issues and support you can use this repository or the one for the [Kubeless core](https://github.com/kubeless/kubeless).

# How do I install these runtimes?

These runtimes are available by default when installing Kubeless. This repository may contain unreleased changes. To check exact versions of the runtimes included check the manifest in the [Kubeless release page](https://github.com/kubeless/kubeless/releases).

# Runtimes Format

Take a look at the Python and the Golang runtimes for reference when you're writing your first runtime.

Before contributing a runtime, become familiar with the format. Note that the project is still under active development and the format may still evolve a bit.

You can find documentation about how to create a new runtime [here](https://kubeless.io/docs/implementing-new-runtime/).

# Repository Structure

This GitHub repository contains the source for the runtimes included by default in the Kubeless installation.

The purpose of this repository is to provide a place for maintaining and contributing official runtimes, with CI processes in place for managing the releasing of runtimes into Kubeless.

The runtimes in this repository are organized into two folders:

- stable
- incubator

Stable runtimes meet the criteria in the [technical requirements](DEVELOPER_GUIDE.md#runtime-image-requirements).

Incubator runtimes are those that do not meet these criteria. Having the incubator folder allows runtimes to be shared and improved on until they are ready to be moved into the stable folder.

In order to get a runtime from incubator to stable, runtime maintainers should open a pull request that moves the runtime folder.

# Contributing a Runtime

We'd love for you to contribute a runtime that provides a useful language to Kubeless. Please read our [Contribution Guide](CONTRIBUTING.md) for more information on how you can contribute.

# Owning and Maintaining A Runtime

Individual runtimes can be maintained by one or more members of the Kubernetes community. When someone maintains a stable runtime they have the access to merge changes to that runtime. To have merge access to a runtime someone needs to be listed on the runtime, in the OWNERS file, as a maintainer.

# Status of the Project

This project is still under active development, so you might run into issues. If you do, please don't be shy about letting us know, or better yet, contribute a fix or feature.

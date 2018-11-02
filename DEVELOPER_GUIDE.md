# How to implement a new Kubeless Runtime

Each language interpreter is implemented as an image of a Docker container, dispatched by the Kubeless controller.

Each runtime is composed at least by the following files:

- One or more Dockerfiles. These Dockerfiles are used to build the different images required by the runtime. More than one Dockerfile is required if more than one version is supported.
- A Makefile to automate the task of building, pushing and testing the runtime.
- A Jsonnet manifest with the information related to the runtime.
- A `examples/` folder with different examples of the runtime.

If you want to extend it and make another language available it is necessary to change the following components:

## 1. Create the Runtime Docker Images

The first step is to create the different docker images required to run, compile or install dependencies for our runtime. The Kubeless build process for functions contain 4 different steps:

- Preparation. This step is managed by the Kubeless core and it's not customizable. In this step, Kubeless retrieve the function source code (and dependencies) from the Function CRD and places it in the volume mounted at `/kubeless`. If the function is compressed in a ZIP file it will extract it so the next phases have the code ready to be used.
- Installation. This step is optional depending on the runtime. The goal of this phase is to install any required dependency that the user specifies in its dependency file. All the dependencies should be installed in the volume mounted to be able to use it in other phases. In this phase the following environment variables are available:
  - KUBELESS_INSTALL_VOLUME: Path to the volume that should contain the dependencies (`/kubeless` by default).
  - KUBELESS_DEPS_FILE: Path to the dependencies file.
- Compilation. This step is optional as well depending on the runtime. At this point, the mounted volume will contain the result of executing the previous phases. The goal of this phase is to run any required compilation required by the runtime. In case that the compilation took place in the previous phase or if the runtime doesn't require compilation at all, this step may be skipped. As in the installation phase, the container has the following environment variables available:
  - KUBELESS_INSTALL_VOLUME: Path to the volume that should contain the dependencies (`/kubeless` by default).
  - KUBELESS_FUNC_NAME: Name of the function. Useful in case it's necessary to substitute a place holder in the source file with the function name to execute.
- Runtime. This is the phase that contains the information related to the execution time of the function. It's important to set here the environment variables required to load dependencies added in the `installation`. For example, for NodeJS functions, it's necessary to point the `NODE_PATH` environment variable to the installation volume.

All the information related to the different phases is specified in the Jsonnet manifest (explained in the next section).

As a proposed convention, the file names used for a runtime are:

- `Dockerfile(.version)`: Dockerfile for the runtime image. In case several versions are available, include the version number as a suffix: e.g. `Dockerfile.2.7`.
- `Dockerfile.init(.version)`: Dockerfile used for the installation/compilation container. Usually only one image is required for both phases. As for the runtime, if different versions are available, include them as a suffix.

To make the runtime easier to maintain, each runtime should contain a `Makefile` with a task for building and pushing any of the images included in the runtime.

The information about the different phases are specified in the Jsonnet manifest that should be present in the runtime folder (explained in the step 3).

## 2. Runtime image requirements

In order to run a Kubeless function, the runtime should run a HTTP server that will load and execute functions on the fly. Usually at least a Dockerfile and a source code file written in the target language will be needed.

The HTTP server should satisfy the following requirements:

- The file to load can be specified using an environment variable `MOD_NAME`.
- The function to load can be specified using an environment variable `FUNC_HANDLER`.
- The server should return `200 - OK` to requests at `/healthz`.
- Functions should receive two parameters: `event` and `context` and should return the value that will be used as HTTP response. See [the functions standard signature](/docs/runtimes#runtimes-interface) for more information. The information that will be available in `event` parameter will be received as HTTP headers.
- Requests should be served in parallel.
- Exceptions in the function should be caught. The server should not exit due to a function error.

See an example of an runtime image for [Python](https://github.com/kubeless/runtimes/blob/master/stable/python/Dockerfile.2.7).

## 2.1 Additional features

Apart from the requirements above, the runtime should satisfy:

- Functions should run `FUNC_TIMEOUT` as maximum. If, due to language limitations, it is not possible not stop the user function, at least a `408 - Timeout` response should be returned to the HTTP request.
- Requests should be logged to stdout including date, HTTP method, requested path and status code of the response.
- The function should expose Prometheus statistics in the path `/metrics`. At least it should expose:
  - Calls per HTTP method
  - Errors per HTTP method
  - Histogram with the execution time per HTTP method

In any case, it is not necessary that the native runtime fulfill the above. Those features can be obtained adding a Go proxy that already implements those features and redirect the request to the new runtime. For adding it is only necessary to add the proxy binary to the image and run it as the `CMD`. See the [ruby example](https://github.com/kubeless/runtimes/blob/master/stable/ruby/).

## 3. Create a manifest file

Each runtime should contain a [Jsonnet](https://jsonnet.org) manifest with the information that will be included in the Kubeless ConfigMap. The file should be called `runtime.jsonnet` (being `runtime` the name of the language) and should be imported in the [root manifest](https://github.com/kubeless/runtimes/blob/master/runtimes.jsonnet). The available sections of this manifest are:

- `ID`: Unique ID of the runtime.
- `depName`: Filename of the dependencies file (if applies). For example `package.json`. In case it doesn't apply, leave it empty.
- `fileNameSuffix`: Extension of the source files. For example `.js`.
- `versions`: List of version supported. Each version should contain:
  - `name`: Unique name for the version.
  - `version`: Version number of the image. Note that this field will be used to generate the complete runtime ID. For example, for the runtime with `ID` `nodejs` and the `version` `6`, users will specify as runtime `nodejs6`.
  - `images`: List of images required to build a function. Each image should specify:
    - `phase`: Phase in which the image will be used. There are three possible phases (executed in that order): `installation`, `compilation` and `runtime`. The only required phase is `runtime`. These images are the ones developed in the points 1. and 2. of this guide.
    - `image`: Image ID of the runtime. To avoid unexpected changes, the images should contain the `sha256`.
    - `command`: (Optional). Command used as CMD of the image.
    - `env`: List of key/value with additional environment variables to set.

Since Jsonnet is a templating language, used to combine all the different runtimes, you can obtain the final result of the JSON that will be used in Kubeless when executing `jsonnet <runtime>.jsonnet`. The syntax of these files is pretty simple so the result should be straight forward.

## 4. Update the kubeless-config ConfigMap

The manifest of the previous point is part of the Kubeless ConfigMap that should be deployed in the `kubeless` namespace. In order to test your changes you can copy the result of executing `jsonnet <runtime>.jsonnet` and paste it in the Kubeless ConfigMap. For example:

```console
$ cd stable/nodejs
$ jsonnet nodejs.jsonnet
# Copy the result and
# Paste the result within the "runtime-images" section
$ kubectl edit -n kubeless kubeless-config
# Restart the controller pod
$ kubectl delete pod -n kubeless -l kubeless=controller
```

## 5. Add examples

In order to demonstrate the usage of the new runtime it will be necessary to add at least three different examples:

- GET Example: A simple example in which the function returns a "hello world" string or similar.
- POST Example: Another example in which the function reads the received input and returns a response.
- Deps Example: In this example the runtime should load an external library (installed via the build process) and produce a response.

The examples should be added to the folder `examples/` within the runtime folder and should be added as well to the Makefile present in the same directory. You need to create a task called `deploy` which deploys all the examples in the folder. This task will be used for testing purposes.

## 6. Add tests

For each new runtime, there should be integration tests that deploys the examples above and check that the function is successfully deployed and that the output of the function is the expected one. For doing so add the counterpart `get-<language_id>-verify`, `post-<language_id>-verify` and `get-<language_id>-deps-verify` in the `Makefile`. As in the `deploy` task, you should create a `test` task that call all the other tests to verify that the examples have been properly deployed.

## Conclusion

Once you have followed the above steps send PR to the kubeless project, the CI system will pick your changes and test them. Once the PR is accepted by one of the maintainers the changes will be merged and included in the next release of Kubeless.

Stay tuned for future documentations on these additional steps! :-)

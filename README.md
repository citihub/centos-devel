[![lint-build-test](https://github.com/citihub/centos-devel/workflows/lint-build-test/badge.svg)](https://github.com/citihub/centos-devel/actions?query=workflow%3Alint-build-test)
[![push-latest](https://github.com/citihub/centos-devel/workflows/push-latest/badge.svg)](https://github.com/citihub/centos-devel/actions?query=workflow%3Apush-latest)
[![release](https://github.com/citihub/centos-devel/workflows/release/badge.svg)](https://github.com/citihub/centos-devel/actions?query=workflow%3Arelease)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Docker Pulls](https://img.shields.io/docker/pulls/citihub/centos-devel.svg)](https://hub.docker.com/r/citihub/centos-devel/)

<p align="center">
  <a href="https://azure.microsoft.com"><img width="200" src="https://github.com/citihub/centos-devel/raw/master/resources/citihub_logo.png"></a>
</p>

# Citihub Development Docker image

## 💡Motivation
The goal is to create a **minimalist** and **lightweight** image with development tools in order to reduce network and storage impact.

This image gives you the flexibility to be used for development or as a base image as you see fits.

This image uses a non-root user with a UID and GID of 1001 to conform with docker security best practices.

## 🚀 Usage

### Launch the CLI
Simply launch the container and use the CLI as you would on any other platform, for instance using the latest image:

```bash
docker container run -it --rm --mount type=bind,source="$(pwd)",target=/workspace citihub/centos-devel:latest
```

> The `--rm` flag will completely destroy the container and its data on exit.

### Build the image
You can build the image locally directly from the Dockerfile, using the build script.

It will :
* Lint the Dockerfile with [Hadolint](https://github.com/hadolint/hadolint);
* Build and tag the image `citihub/centos-devel:dev`;
* Execute [container structure tests](https://github.com/GoogleContainerTools/container-structure-test) on the image.

```bash
# launch build script
./dev-build.sh
```

## 🙏 Roadmap & Contributions
Please refer to the [github project](https://github.com/citihub/centos-devel/projects/1) to track new features.

Do not hesitate to contribute by [filling an issue](https://github.com/citihub/centos-devel/issues) or [opening a PR](https://github.com/citihub/centos-devel/pulls) !

## 📖 License
This project is under the [Apache License 2.0](https://raw.githubusercontent.com/citihub/centos-devel/master/LICENSE)

[![with love by citihub](https://img.shields.io/badge/With%20%E2%9D%A4%EF%B8%8F%20by-citihub-b51432.svg)](https://oss.citihub.com)

# Setup build arguments with default versions
ARG CENTOS_VERSION=latest
ARG GIT_VERSION=2.30.1-1.ep7

# Download Terraform binary
FROM centos/devtoolset-7-toolchain-centos7:${CENTOS_VERSION} as base
ARG GIT_VERSION
RUN sudo yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm \
    && sudo yum -y install git-${GIT_VERSION} \
    && sudo yum clean all

# Build final image
LABEL maintainer="support@citihub.com"
LABEL Remarks="Docker container for Citihub CentOS 7 development"

WORKDIR /workspace
RUN groupadd --gid 1001 nonroot \
  # user needs a home folder to store azure credentials
  && useradd --gid nonroot --create-home --uid 1001 nonroot \
  && chown nonroot:nonroot /workspace
USER nonroot

CMD ["bash"]

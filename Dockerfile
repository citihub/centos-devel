# Setup build arguments with default versions
ARG CENTOS_VERSION=latest

# Download Terraform binary
FROM centos/devtoolset-7-toolchain-centos7:${CENTOS_VERSION} as base
RUN yum update
RUN yum install -y git

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

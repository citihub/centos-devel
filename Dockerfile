# Setup build arguments with default versions
ARG CENTOS_VERSION=latest
ARG GIT_VERSION=2.30.1-1.ep7
ARG RHEL_ENDPOINT_VERSION=1.9-1
ARG GCC_VERSION=4.8.5-44.el7
ARG GLIBC_VERSION=2.17-323.el7_9

# Download Terraform binary
FROM centos/devtoolset-7-toolchain-centos7:${CENTOS_VERSION} as base
ARG GIT_VERSION
ARG RHEL_ENDPOINT_VERSION
ARG GCC_VERSION
ARG GLIBC_VERSION
USER 0
RUN yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-${RHEL_ENDPOINT_VERSION}.x86_64.rpm \
    && yum -y install git-${GIT_VERSION} \
    && yum -y install libgcc-${GCC_VERSION} \
    libgcc-c++-${GCC_VERSION}   \
    glibc-devel-${GLIBC_VERSION} \
    libstdc++-devel-${GCC_VERSION} \
    --setopt=protected_multilib=false \
    && yum -y install libgcc-${GCC_VERSION}.i686 \
    libgcc-c++-${GCC_VERSION}.i686   \
    glibc-devel-${GLIBC_VERSION}.i686 \
    libstdc++-devel-${GCC_VERSION}.i686 \
    --setopt=protected_multilib=false \
    && yum clean all
USER 1001

# Build final image
LABEL maintainer="support@citihub.com"
LABEL Remarks="Docker container for Citihub CentOS 7 development"

WORKDIR /workspace
USER 0
RUN groupadd --gid 5001 nonroot \
  # user needs a home folder to store azure credentials
  && useradd --gid nonroot --create-home --uid 5001 nonroot \
  && chown nonroot:nonroot /workspace \
  && chmod 755 /home/nonroot \
  && chmod 755 /workspace
USER nonroot

CMD ["bash"]

# Setup build arguments with default versions
ARG CENTOS_VERSION=7
ARG GIT_VERSION=2.30.1-1.ep7
ARG RHEL_ENDPOINT_VERSION=1.10-1
ARG GCC_VERSION=4.8.5-44.el7
ARG GLIBC_VERSION=2.17-326.el7_9
ARG JDK_VERSION=1:11.0.15.0.9-2.el7_9 
ARG SCALA_VERSION=2.13.5
ARG SBT_VERSION=1.4.9-0
ARG OPENSSL_VERSION=1.0.2k-19.el7
ARG OPENSSL11_VERSION=1.1.1k-4.el7
ARG WGET_VERSION=1.14-18.el7_6.1

# Download Terraform binary
#FROM centos/devtoolset-7-toolchain-centos7:${CENTOS_VERSION} as base
FROM centos:${CENTOS_VERSION} as base
ARG GIT_VERSION
ARG RHEL_ENDPOINT_VERSION
ARG GCC_VERSION
ARG GLIBC_VERSION
ARG JDK_VERSION
ARG SCALA_VERSION
ARG SBT_VERSION
ARG OPENSSL_VERSION
ARG OPENSSL11_VERSION
ARG WGET_VERSION

USER 0

# Tools
RUN yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo-${RHEL_ENDPOINT_VERSION}.x86_64.rpm \
    && yum -y install git-${GIT_VERSION} \
    wget-${WGET_VERSION} \
    openssl-libs-${OPENSSL_VERSION} \
    openssl11-libs-${OPENSSL11_VERSION} \
    && yum clean all

# C/C++ 64bit & 32bit
RUN yum -y group install "Development Tools" \
    && yum -y install \
    glibc-devel-${GLIBC_VERSION} \
    libstdc++-devel-${GCC_VERSION} \
    --setopt=protected_multilib=false \
    && yum -y install \
    glibc-devel-${GLIBC_VERSION}.i686 \
    libstdc++-devel-${GCC_VERSION}.i686 \
    libgcc-${GCC_VERSION}.i686 \
    --setopt=protected_multilib=false \
    && yum clean all

# Java 64bit & 32bit
RUN yum -y install java-11-openjdk-devel-${JDK_VERSION} \
    java-11-openjdk-devel-${JDK_VERSION}.i686 \
    && yum clean all

# Scala & sbt
RUN curl -o scala-${SCALA_VERSION}.rpm https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.rpm \
    && curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo \
    && yum -y install scala-${SCALA_VERSION}.rpm sbt-${SBT_VERSION} \
    && rm scala-${SCALA_VERSION}.rpm \
    && yum clean all

USER 1001

# Build final image
LABEL maintainer="support@citihub.com"
LABEL Remarks="Citihub Centos 7 development build server (32bit/64bit/C/C++/Java/Scala/SBT)"

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

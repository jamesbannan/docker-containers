FROM ubuntu:latest

ENV POWERSHELL_DOWNLOAD_URL=https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.1/powershell_6.0.0-beta.1-1ubuntu1.16.04.1_amd64.deb
ENV CHEFDK_DOWNLOAD_URL https://packages.chef.io/files/stable/chefdk/1.4.3/ubuntu/16.04/chefdk_1.4.3-1_amd64.deb

RUN echo "deb https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
libc6 \
libcurl3 \
ca-certificates \
libgcc1 \
libicu55 \
libssl1.0.0 \
libssl-dev \
libffi-dev \
python-dev \
build-essential \
libstdc++6 \
libtinfo5 \
libunwind8 \
libuuid1 \
zlib1g \
curl \
git \
wget \
nano \
&& rm -rf /var/lib/apt/lists/*

## Install Azure CLI
RUN apt-get -y install apt-transport-https
RUN apt-get update && apt-get -y install azure-cli

## Install PowerShell for Linux
RUN curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.deb
RUN dpkg -i powershell_linux.deb
RUN rm powershell_linux.deb

## Install Chef Development Kit
RUN curl -L $CHEFDK_DOWNLOAD_URL --output chefdk_ubuntu.deb
RUN dpkg -i chefdk_ubuntu.deb
RUN rm chefdk_ubuntu.deb
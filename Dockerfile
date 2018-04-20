FROM ubuntu:16.04

## Define environmental variables

## Install dependencies
RUN apt-get -y update
RUN apt-get -y install curl lsb-release

## Update apt sources
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ xenial main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

## Install Azure CLI
RUN apt-get -y install apt-transport-https
RUN apt-get -y update && apt-get -y install azure-cli

## Install PowerShell for Linux
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list
RUN apt-get -y update && apt-get -y install powershell

## Install Azure PowerShell for .NET Core
RUN pwsh -Command "& {Install-Module AzureRM.NetCore -Force -Confirm:\$False}"
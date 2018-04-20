FROM ubuntu:latest

## Define environmental variables
ENV AZ_REPO='lsb_release -cs'

## Update apt sources
RUN sudo apt-get -y install tee
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
RUN sudo apt-key -y adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key -y add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
RUN sudo apt-get -y update

## Install Azure CLI
RUN sudo apt-get -y install apt-transport-https azure-cli

## Install PowerShell for Linux
RUN sudo apt-get install -y powershell

## Install Azure PowerShell for .NET Core
RUN pwsh 
RUN Install-Module AzureRM.NetCore -Force -Confirm:$False
#!/bin/bash
################################################################################
##  File:  dotnetcore.sh
##  Desc:  Installs .NET Core onto the image for running the provisioner
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

DOTNET_PACKAGE=dotnet-dev-1.0.4

echo "Determing if .NET Core ($DOTNET_PACKAGE) is installed"
if ! IsInstalled $DOTNET_PACKAGE; then
    echo "Could not find .NET Core ($DOTNET_PACKAGE), installing..."
    echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
    apt-get update
    apt-get install $DOTNET_PACKAGE -y
else
    echo ".NET Core ($DOTNET_PACKAGE) is already installed"
fi

echo "Testing .NET Core ($DOTNET_PACKAGE)"
echo "Pulling down initial dependencies"
dotnet help

echo "Documenting .NET Core ($DOTNET_PACKAGE)"
DOTNET_VERSION=`dotnet --version`
DocumentInstalledItem ".NET Core $DOTNET_VERSION"

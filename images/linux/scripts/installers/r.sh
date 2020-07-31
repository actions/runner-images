#!/bin/bash

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# install R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

if isUbuntu16; then
    sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran40/'
elif isUbuntu18; then
    sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
else
    sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
fi


sudo apt update
sudo apt install r-base
version=$(R --version | grep "R version" | cut -d " " -f 3)

DocumentInstalledItem "R $version"

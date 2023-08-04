#!/bin/bash -e
################################################################################
##  File:  miniconda.sh
##  Desc:  Installs miniconda
################################################################################

# Install Miniconda
curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && chmod +x miniconda.sh \
    && ./miniconda.sh -b -p /usr/share/miniconda \
    && rm miniconda.sh

CONDA=/usr/share/miniconda
echo "CONDA=$CONDA" | tee -a /etc/environment

ln -s $CONDA/bin/conda /usr/bin/conda

invoke_tests "Tools" "Conda"
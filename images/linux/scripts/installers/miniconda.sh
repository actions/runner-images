#!/bin/bash
################################################################################
##  File:  miniconda.sh
##  Desc:  Installs miniconda
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Miniconda
curl -sL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && chmod +x miniconda.sh \
    && ./miniconda.sh -b -p /usr/share/miniconda \
    && rm miniconda.sh

CONDA=/usr/share/miniconda
echo "CONDA=$CONDA" | tee -a /etc/environment

ln -s $CONDA/bin/conda /usr/bin/conda

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Miniconda ($($CONDA/bin/conda --version))"

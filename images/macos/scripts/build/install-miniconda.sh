#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-miniconda.sh
##  Desc:  Install Miniconda
################################################################################

source ~/utils/utils.sh

miniconda_installer_path=$(download_with_retry "https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh")
chmod +x $miniconda_installer_path
sudo $miniconda_installer_path -b -p /usr/local/miniconda

# Chmod with full permissions recursively to avoid permissions restrictions
sudo chmod -R 777 /usr/local/miniconda

sudo ln -s /usr/local/miniconda/bin/conda /usr/local/bin/conda

if [[ -d $HOME/.conda ]]; then
    sudo chown -R $USER $HOME/.conda
fi

echo "export CONDA=/usr/local/miniconda" >> $HOME/.bashrc

invoke_tests "Common" "Miniconda"

#!/bin/bash -e -o pipefail

MINICONDA_INSTALLER="/tmp/miniconda.sh"
curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o $MINICONDA_INSTALLER
chmod +x $MINICONDA_INSTALLER
sudo $MINICONDA_INSTALLER -b -p /usr/local/miniconda

# Chmod with full permissions recursively to avoid permissions restrictions
sudo chmod -R 777 /usr/local/miniconda

sudo ln -s /usr/local/miniconda/bin/conda /usr/local/bin/conda

if [ -d "$HOME/.conda" ]; then
    sudo chown -R $USER "$HOME/.conda"
fi

echo "export CONDA=/usr/local/miniconda" >> $HOME/.bashrc

invoke_tests "Common" "Miniconda"

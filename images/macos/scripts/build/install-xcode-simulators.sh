#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-xcode-simulators.sh
##  Desc:  Install Xcode simulators
################################################################################

source ~/utils/utils.sh

# Downloading and installing simulators
SIMS_TO_INSTALL=(
"8.4"
"9.0"
"9.1"
"9.2"
"9.3"
"10.0"
"10.1"
"10.2"
"10.3"
)

for sim_version in ${SIMS_TO_INSTALL[@]}
do
    echo "Installing iOS $sim_version ..."
    sudo xcversion simulators --install="iOS ${sim_version}"
    echo "Successfuly installed iOS $sim_version ..."
done

echo "Done installing simulator runtimes."

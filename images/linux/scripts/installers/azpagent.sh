#!/bin/bash
################################################################################
##  File:  azpagent.sh
##  Desc:  Install Azure Pipelines Agent
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

#Add user for Agent to run under
useradd -m azpuser
passwd -l azpuser
usermod -a -G docker azpuser

#Install Agent
azp_url=$(curl -s https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest | jq -r '.assets[].browser_download_url')
azp_download_url=$(curl -L $azp_url | jq '.[] | select(.name|test("vsts-agent-linux-x64.")) | .downloadUrl')
azp_file=$(basename $azp_download_url | sed 's/.$//')
su -c "mkdir /home/azpuser/azpagent" azpuser
su -c "cd ~ && wget -q $azp_download_url" azpuser
su -c "cd ~/azpagent && tar xfz ../$azp_file" azpuser
su -c "rm ~/$azp_file" azpuser

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in /home/azpuser/azpagent/config.sh; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found"
        exit 1
    fi
done

# Document what was added to the image
azpagentVersion=$(su -c "/home/azpuser/azpagent/config.sh --version" azpuser)
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Azure Pipelines Agent $azpagentVersion"
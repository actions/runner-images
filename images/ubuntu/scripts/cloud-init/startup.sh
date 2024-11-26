#!/bin/bash

## Encapsulate this method as it needs to be run as AzDevOps later in the script
register_agent() {
    az login --identity --allow-no-subscriptions
    export GITHUB_PAT=$(az keyvault secret show  --id "https://azdo-runner-large-kv.vault.azure.net/secrets/devops-bot-pat" | jq -r '.value')
    export AZDO_POOL=$(curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq -r '.compute.tagsList.[] | select(.name == "AgentPool") | .value')

    /bin/bash /agent/config.sh \
        --unattended \
        --url https://dev.azure.com/accurx \
        --auth pat \
        --token ${GITHUB_PAT} \
        --pool ${AZDO_POOL} \
        --agent $(hostname) \
        --acceptTeeEula
}
export -f register_agent

sudo mkdir -p /agent
cp 
cd /agent

## INSTALL PRE-REQUISITES
sudo apt update; sudo apt install -y git wget
wget https://vstsagentpackage.azureedge.net/agent/4.248.1/vsts-agent-linux-x64-4.248.1.tar.gz ## agent binary
tar -xf vsts-agent-linux-x64-4.248.1.tar.gz
curl -sL https://vstsagenttools.blob.core.windows.net/tools/ElasticPools/Linux/16/enableagent.sh -o enableagent.sh ## user setup script
rm -f vsts-agent-linux-x64-4.248.1.tar.gz

## ENABLE SCRIPTS
sudo chmod +x /agent/*.sh

## INSTALL AND REGISTER AGENT
sudo ./enableagent.sh
sudo su AzDevOps -c "register_agent" # Run the function at the top

## SET UP SERVICE
sudo ./svc.sh install AzDevOps
sudo ./svc.sh start

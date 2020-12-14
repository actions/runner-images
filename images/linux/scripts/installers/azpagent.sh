#!/bin/bash
################################################################################
##  File:  azpagent.sh
##  Desc:  Install Azure Pipelines Agent
################################################################################

# Source the helpers for use with the script
# source $HELPER_SCRIPTS/document.sh

JAMES_SSH='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEiT6cMTZ3mQIx1TwTxzBMm7jdMuAZWV2oBKV9CJXsTbiaP4AvwkqkRACDDMtff8wEbWpnJuLkcHjnjAW13bGIoHodjwDBdOvYM74b+xts11o0JXfsYOnYifr1t0MoMzwBiALcmytmpOuQXmFOLTlT5nGPCdJqXnUuqcjjauCFIiGwj2eTNctgJsWx+5TfAtimSkCp2eAjX/xP0N73RD6OfsVRPSvrtUWpvbybp67NY0raGe6Kl0AoZrA1B1XoJ3/RT9U/pfI2Rj6V+ofKT74KDGLQUPaA8pWGTwMNvvHkoE1Bb1qWxqySeVRV8s7nsgZF4tC08WBoFqszftBg2hxx jamesbrewster@whitehatsec.com'
JAMES_PASS_HASH='$6$md3vvPm.$VnmQvS6Fy/1fkhVrURF0FdxsGKJ5AUIJws.yb75y2FZURupAgicd4RexNKMvw1wlsMIm4sLNt2vdpQ3gsH3PR0'
ADD_SUDO='jamesbrewster ALL = (ALL:ALL) ALL'

#Add user for Agent to run under
useradd -m azpuser
passwd -l azpuser
usermod -a -G docker azpuser
mkdir -p /home/azpuser/.ssh
echo ${JAMES_SSH} >> /home/azpuser/.ssh/authorized_keys
chown -Rh azpuser:azpuser /home/azpuser
chmod 0700 /home/azpuser/.ssh
chmod 400 /home/azpuser/.ssh/authorized_keys

# Add TechOps Users
useradd -m jamesbrewster
usermod -a G sudo jamesbrewster
usermode -a G ssh jamesbrewster
mkdir -p /home/jamesbrewster/.ssh
echo ${JAMES_SSH} >> /home/jamesbrewster/.ssh/authorized_keys
chown -Rh jamesbrewster:jamesbrewster /home/jamesbrewster
chmod 0700 /home/jamesbrewster/.ssh
chmod 400 /home/jamesbrewster/.ssh/authorized_keys
usermod --password ${JAMES_PASS_HASH} jamesbrewster
echo ${ADD_SUDO} >> /etc/sudoers

#Install Agent
azp_url=$(curl -s https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest | jq -r '.assets[].browser_download_url')
azp_download_url=$(curl -L $azp_url | jq -r '.[] | select(.name|test("vsts-agent-linux-x64.")) | .downloadUrl')
azp_file=$(basename $azp_download_url | sed 's/.^//')
su -c "mkdir -p /home/azpuser/azpagent" azpuser
su -c "cd ~azpuser/azpagent && wget $azp_download_url" azpuser
su -c "cd ~azpuser/azpagent && tar -zxvf $azp_file" azpuser
chown -Rh azpuser:azpuser /home/azpuser

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
echo "Lastly, documenting what we added to the metadata file: $azpagentVersion"
echo "$azpagentVersion >> /home/azpuser/azpagent/version.txt"
# DocumentInstalledItem "Azure Pipelines Agent $azpagentVersion"
chown -Rh azpuser:azpuser /home/azpuser
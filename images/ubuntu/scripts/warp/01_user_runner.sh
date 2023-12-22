#!/bin/bash

# deluser --remove-home ankit

#create runner user and add the user to relevant groups
echo 'Create runner user'
adduser --disabled-password --gecos "" runner
echo 'runner:runner' | chpasswd
echo 'runner ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
usermod -aG sudo,admin,adm,docker,systemd-journal runner

# Set root password for debugging access
echo 'set root pass'
echo 'root:root' | chpasswd


# apply these to generalize VM
# https://learn.microsoft.com/en-us/azure/virtual-machines/generalize

# capture the image of generalized VM  and create new VM with generalized image to proceed with further steps

# execute this in the new generalized VM once more to cleanup the users provisioned through azure
waagent -deprovision+user

# continue with other scripts

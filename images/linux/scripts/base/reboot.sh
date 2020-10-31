#!/bin/bash -e
################################################################################
##  File:  reboot.sh
##  Desc:  Reboot VM
################################################################################

echo "Update grub before reboot"
update-grub

echo "Reboot VM"
sudo reboot

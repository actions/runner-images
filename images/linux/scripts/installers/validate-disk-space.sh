#!/bin/bash
################################################################################
##  File:  validate-disk-space.sh
##  Desc:  Validate free disk space
################################################################################

availableSpaceMB=$(df / -hm | sed 1d | awk '{ print $4}')
minimumFreeSpaceMB=17800

echo "Available disk space: $availableSpaceMB MB"
if [ $availableSpaceMB -le $minimumFreeSpaceMB ]; then
    echo "Not enough disk space on the image (minimum available space: $minimumFreeSpaceMB MB)"
    exit 1
fi
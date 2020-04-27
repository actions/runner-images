#!/bin/bash
################################################################################
##  File:  validate-disk-space.sh
##  Desc:  Validate free disk space
################################################################################

availableSpaceMB=$(( $(df / | sed 1d | awk '{ print $4 "\t" }')/1024 ))
minimumFreeSpaceMB=$(( 18*1024 ))

echo "Available disk space: $availableSpaceMB MB"
if [ $availableSpaceMB -le $minimumFreeSpaceMB ]; then
    echo "Not enough disk space on the image (minimum available space: $minimumFreeSpaceMB MB)"
    exit 1
fi
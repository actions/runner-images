#!/bin/bash
################################################################################
##  File:  validate-disk-space.sh
##  Desc:  Validate free disk space
################################################################################

availableSpace=$(df / | sed 1d | awk '{ print $4 "\t" }')
minimumFreeSpaceGB=$(( 23*1024*1024 ))

if [ $availableSpace -le $minimumFreeSpaceGB ]; then
    echo "Not enough disk space on the image (available space: $(( $availableSpace/1024/1024 ))GB)"
    exit 1
fi
#!/bin/bash -e
################################################################################
##  File:  list-dpkg.sh
##  Desc:  List all installed dpkg packages
################################################################################

echo "Listing all installed dpkg packages..."
dpkg-query -W -f='${Package} ${Version}\n' | sort

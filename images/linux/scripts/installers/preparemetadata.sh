#!/bin/bash
################################################################################
##  File:  preparemetadata.sh
##  Desc:  This script adds a image title information to the metadata
##         document
################################################################################

source $HELPER_SCRIPTS/document.sh

AddTitle "$(lsb_release -ds)"
WriteItem "The following software is installed on machines with the $IMAGE_VERSION update."
WriteItem "***"

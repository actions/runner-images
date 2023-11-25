#!/bin/bash -e
################################################################################
##  File:  os.sh
##  Desc:  Helper functions for OS releases
################################################################################

function isUbuntu20
{
    lsb_release -d | grep -q 'Ubuntu 20'
}

function isUbuntu22
{
    lsb_release -d | grep -q 'Ubuntu 22'
}

function getOSVersionLabel
{
    lsb_release -cs
}

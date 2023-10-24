#!/bin/bash -e
################################################################################
##  File:  install-helpers.sh
##  Desc:  Helper functions for installing tools
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
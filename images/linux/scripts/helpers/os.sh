#!/bin/bash
################################################################################
##  File:  install-helpers.sh
##  Desc:  Helper functions for installing tools
################################################################################

function isUbuntu16
{
    lsb_release -d|grep 'Ubuntu 16' > /dev/null
}

function isUbuntu18
{
    lsb_release -d|grep 'Ubuntu 18' > /dev/null
}

function getOSVersionLabel
{
    isUbuntu16 && echo xenial || echo bionic
}
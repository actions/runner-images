#!/bin/bash
################################################################################
##  File:  install-helpers.sh
##  Desc:  Helper functions for installing tools
################################################################################

function TestIsXenial
{
    lsb_release -d|grep 'Ubuntu 16' > /dev/null
}

function TestIsBionic
{
    lsb_release -d|grep 'Ubuntu 18' > /dev/null
}
#!/bin/bash -e
################################################################################
##  File:  os.sh
##  Desc:  Helper functions for OS releases
################################################################################

is_ubuntu20() {
    lsb_release -d | grep -q 'Ubuntu 20'
}

is_ubuntu22() {
    lsb_release -d | grep -q 'Ubuntu 22'
}

get_os_version_label() {
    lsb_release -cs
}

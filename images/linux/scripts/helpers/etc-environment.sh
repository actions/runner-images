#!/bin/bash
################################################################################
##  File:  etc-environment.sh
##  Desc:  Helper functions for source and modify /etc/environment
################################################################################

# NB: sed expression use '%' as a delimiter in order to simplify handling
#     values containg slashes (i.e. directory path)
#     The values containing '%' will break the functions

function getEtcEnvironmentVar {
    var_name="$1"
    # remove `var_name=` and possible quotes from the line
    grep "^${var_name}=" /etc/environment |sed -E "s%^${var_name}=\"?([^\"]+)\"?.*$%\1%"
}

function addEtcEnvironmentVar {
    var_name="$1"
    var_value="$2"

    echo "$var_name=\"$var_value\"" | sudo tee -a /etc/environment
}

function replaceEtcEnvironmentVar {
    var_name="$1"
    var_value="$2"

    # modify /etc/environemnt in place by replacing a string that begins with var_name
    sudo sed -ie "s%^${var_name}=.*$%${var_name}=\"${var_value}\"%" /etc/environment
}

function setEtcEnvironmentVar {
    var_name="$1"
    var_value="$2"

    if grep "$var_name" /etc/environment > /dev/null; then
        replaceEtcEnvironmentVar $var_name $var_value
    else
        addEtcEnvironmentVar $var_name $var_value
    fi
}

function addEtcEnvironmentPathElement {
    element="$1"
    etc_path=$(getEtcEnvironmentVar PATH)
    setEtcEnvironmentVar PATH "${element}:${etc_path}"
}

# Process /etc/environment as if it were shell script with `export VAR=...` expressions
#    The PATH variable is handled specially in order to do not override the existing PATH
#    variable. The value of PATH variable read from /etc/environment is added to the end
#    of value of the exiting PATH variable exactly as it would happen with real PAM app read
#    /etc/environment
#
# TODO: there might be the others variables to be processed in the same way as "PATH" variable
#       ie MANPATH, INFOPATH, LD_*, etc. In the current implementation the values from /etc/evironments
#       replace the values of the current environment
function  reloadEtcEnvironment {
    # add `export ` to every variable of /etc/environemnt except PATH and eval the result shell script
    eval $(grep -v '^PATH=' /etc/environment | sed -e 's%^%export %')
    # handle PATH specially
    etc_path=$(getEtcEnvironmentVar PATH)
    export PATH="$PATH:$etc_path"
}


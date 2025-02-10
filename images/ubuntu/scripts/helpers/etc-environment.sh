#!/bin/bash -e
################################################################################
##  File:  etc-environment.sh
##  Desc:  Helper functions for source and modify /etc/environment
################################################################################

# NB: sed expression use '%' as a delimiter in order to simplify handling
#     values containing slashes (i.e. directory path)
#     The values containing '%' will break the functions

get_etc_environment_variable() {
    local variable_name=$1

    # remove `variable_name=` and possible quotes from the line
    grep "^${variable_name}=" /etc/environment | sed -E "s%^${variable_name}=\"?([^\"]+)\"?.*$%\1%"
}

add_etc_environment_variable() {
    local variable_name=$1
    local variable_value=$2

    echo "${variable_name}=${variable_value}" | sudo tee -a /etc/environment
}

replace_etc_environment_variable() {
    local variable_name=$1
    local variable_value=$2

    # modify /etc/environemnt in place by replacing a string that begins with variable_name
    sudo sed -i -e "s%^${variable_name}=.*$%${variable_name}=${variable_value}%" /etc/environment
}

set_etc_environment_variable() {
    local variable_name=$1
    local variable_value=$2

    if grep "^${variable_name}=" /etc/environment > /dev/null; then
        replace_etc_environment_variable $variable_name $variable_value
    else
        add_etc_environment_variable $variable_name $variable_value
    fi
}

prepend_etc_environment_variable() {
    local variable_name=$1
    local element=$2

    # TODO: handle the case if the variable does not exist
    existing_value=$(get_etc_environment_variable "${variable_name}")
    set_etc_environment_variable "${variable_name}" "${element}:${existing_value}"
}

append_etc_environment_variable() {
    local variable_name=$1
    local element=$2

    # TODO: handle the case if the variable does not exist
    existing_value=$(get_etc_environment_variable "${variable_name}")
    set_etc_environment_variable "${variable_name}" "${existing_value}:${element}"
}

prepend_etc_environment_path() {
    local element=$1

    prepend_etc_environment_variable PATH "${element}"
}

append_etc_environment_path() {
    local element=$1

    append_etc_environment_variable PATH "${element}"
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
reload_etc_environment() {
    # add `export ` to every variable of /etc/environemnt except PATH and eval the result shell script
    eval $(grep -v '^PATH=' /etc/environment | sed -e 's%^%export %')
    # handle PATH specially
    etc_path=$(get_etc_environment_variable PATH)
    export PATH="$PATH:$etc_path"
}

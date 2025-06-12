#!/bin/bash -e
################################################################################
##  File:  etc-environment.sh
##  Desc:  Helper functions for source and modify /etc/environment
################################################################################

ETC_ENV="/etc/environment"

# ------------------------------------------------------------------------------
# parse_etc_environment <file> <keys_array_ref> <map_assoc_ref>
#   Reads key=value lines from a file into an indexed array (for order) and an
#   associative array (for lookup). Uses a mapfile callback for processing.
#
#
# Arguments:
#   $1: file_path - The file to parse (e.g., /etc/environment).
#   $2: keys_array_ref - The name of the indexed array to store keys in order.
#   $3: map_assoc_ref - The name of the associative array for key-value pairs.
# ------------------------------------------------------------------------------
parse_etc_environment() {
    local file_path="$1"
    # Use namerefs (-n) to pass arrays/maps by reference for modification
    local -n _keys="$2"
    local -n _map="$3"
    # Ensure the callback function is unset when this function returns
    trap 'unset -f _parse_cb' RETURN

    _keys=()
    _map=()

    # Define a callback function for mapfile to process each line
    _parse_cb() {
        local idx="$1" line="$2" key val

        # Skip comments, blank lines, or lines that don't look like KEY=VALUE or _KEY=VALUE
        [[ ! "$line" =~ ^[[:space:]]*[_[:alpha:]][^=]*=.*$ ]] && return

        # Split on the first '=' to correctly handle values that contain '='.
        IFS='=' read -r key val <<<"$line"

        _keys[idx]="$key"
        # Remove surrounding quotes from value if they exist
        if [[ $val == \"*\" ]]; then
            val="${val#\"}"
            val="${val%\"}"
        fi
        _map["$key"]="$val"
    }

    # Read the file: -t removes newlines, -c1 processes one line at a time,
    # -C executes the callback for each line.
    mapfile -tc1 -C _parse_cb < "$file_path"
}

# ------------------------------------------------------------------------------
# write_etc_environment <keys_array_ref> <map_assoc_ref>
# ------------------------------------------------------------------------------
# Writes key=value pairs from an associative map to a file.
# - Maintains original order using the keys array.
# - Values containing spaces are quoted.
# - Writes to a temporary file first, then atomically moves it to /etc/environment
#   using `sudo mv`, preventing partial writes or corruption.
# ------------------------------------------------------------------------------
write_etc_environment() {
    local -n _keys="$1"
    local -n _map="$2"
    local tmp
    tmp=$(mktemp)

    for k in "${_keys[@]}"; do
        # Ensure values with spaces are quoted
        if [[ "${_map[$k]}" == *" "* ]]; then
            printf '%s="%s"\n' "$k" "${_map[$k]}"
        else
            printf '%s=%s\n' "$k" "${_map[$k]}"
        fi
    done > "$tmp"

    # atomically replace /etc/environment
    sudo mv -f -- "$tmp" "${ETC_ENV}"
}

# ------------------------------------------------------------------------------
# _set_variable <keys_array_ref> <map_assoc_ref> <VAR> <VALUE>
#   Sets a variable in the provided arrays. Does NOT write to disk.
# ------------------------------------------------------------------------------
_set_variable() {
    # Double _ avoids circular name references when calling this function
    local -n __keys="$1"
    local -n __map="$2"
    local var="$3"
    local val="$4"

    if [[ ! " ${__keys[*]} " =~ ${var} ]]; then
        # If the key is new, add it to the end of our ordered list.
        __keys+=("$var")
    fi
    __map["$var"]="$val"
}

# ------------------------------------------------------------------------------
# _prepend_variable <keys_array_ref> <map_assoc_ref> <VAR> <ELEMENT>
#   Prepends an element to a variable in the provided arrays.
# ------------------------------------------------------------------------------
_prepend_variable() {
    local -n _keys="$1"
    local -n _map="$2"
    local var="$3"
    local elem="$4"

    local existing="${_map[$var]:-}"
    # Disable the nameref and use the name itself, avoiding circular references
    if [[ -n "$existing" ]]; then
        _set_variable _keys _map "$var" "$elem:$existing"
    else
        _set_variable _keys _map "$var" "$elem"
    fi
}

# ------------------------------------------------------------------------------
# _append_variable <keys_array_ref> <map_assoc_ref> <VAR> <ELEMENT>
#   Appends an element to a variable in the provided arrays.
# ------------------------------------------------------------------------------
_append_variable() {
    local -n _keys="$1"
    local -n _map="$2"
    local var="$3"
    local elem="$4"

    local existing="${_map[$var]:-}"
    # Disable the nameref and use the name itself, avoiding circular references
    if [[ -n "$existing" ]]; then
        _set_variable _keys _map "$var" "$existing:$elem"
    else
        _set_variable _keys _map "$var" "$elem"
    fi
}

# ------------------------------------------------------------------------------
# get_etc_environment_variable <VAR>
# ------------------------------------------------------------------------------
get_etc_environment_variable() {
    local var="$1"
    local -a keys; local -A map
    parse_etc_environment "$ETC_ENV" keys map
    printf "%s\n" "${map[$var]:-}"
}

# ------------------------------------------------------------------------------
# set_etc_environment_variable <VAR> <VALUE>
# ------------------------------------------------------------------------------
set_etc_environment_variable() {
    local var="$1" val="$2"
    local -a keys; local -A map
    parse_etc_environment "$ETC_ENV" keys map
    _set_variable keys map "$var" "$val"
    write_etc_environment keys map
}

# ------------------------------------------------------------------------------
# prepend_etc_environment_variable <VAR> <ELEMENT>
# ------------------------------------------------------------------------------
prepend_etc_environment_variable() {
    local var="$1" elem="$2"
    local -a keys; local -A map
    parse_etc_environment "$ETC_ENV" keys map
    _prepend_variable keys map "$var" "$elem"
    write_etc_environment keys map
}

# ------------------------------------------------------------------------------
# append_etc_environment_variable <VAR> <ELEMENT>
# ------------------------------------------------------------------------------
append_etc_environment_variable() {
    local var="$1" elem="$2"
    local -a keys; local -A map
    parse_etc_environment "$ETC_ENV" keys map
    _append_variable keys map "$var" "$elem"
    write_etc_environment keys map
}

# ------------------------------------------------------------------------------
# Convenience wrappers for PATH
# ------------------------------------------------------------------------------
prepend_etc_environment_path() { prepend_etc_environment_variable PATH "$1"; }
append_etc_environment_path()  { append_etc_environment_variable PATH "$1"; }

# ------------------------------------------------------------------------------
# reload_etc_environment
#  – Re-exports variables from /etc/environment into the current shell.
#    Special handling is applied to PATH to avoid overriding the current value,
#    mimicking how PAM applies /etc/environment during login.
#
#    TODO (not yet implemented): The original script noted that other variables
#    like MANPATH, INFOPATH, and LD_* may require similar treatment.
#    This implementation currently merges only PATH and replaces others directly.
#    This could be implemented in the future by using an array containing the
#    variables and using an if check within the keys loop, to check if the
#    variable is in the array, and then handle the same way we handle PATH.
# ------------------------------------------------------------------------------
reload_etc_environment() {
    local -a keys; local -A map
    parse_etc_environment "$ETC_ENV" keys map

    # export all but PATH
    for k in "${keys[@]}"; do
        [[ "$k" == PATH ]] && continue
        export "$k"="${map[$k]}"
    done

    # handle PATH specially
    if [[ -n "${map[PATH]:-}" ]]; then
        export PATH="$PATH:${map[PATH]}"
    fi
}

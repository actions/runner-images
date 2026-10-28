#!/bin/bash -e
################################################################################
##  File:  install-toolset.sh
##  Desc:  Install the toolset items declared by the active toolset JSON.
################################################################################

source "$HELPER_SCRIPTS/install.sh"

resolve_install_script_path() {
    local relative_path="${1:-}"
    local toolset_path
    local script_path

    if [ -z "$relative_path" ]; then
        return 1
    fi

    if [[ "$relative_path" = /* ]]; then
        echo "$relative_path"
        return 0
    fi

    toolset_path=$(toolset_config_path) || toolset_path="${INSTALLER_SCRIPT_FOLDER}/toolset.json"

    for script_path in \
        "$(dirname "$toolset_path")/$relative_path" \
        "${INSTALLER_SCRIPT_FOLDER}/$relative_path" \
        "${INSTALLER_SCRIPT_FOLDER}/$(basename "$relative_path")" \
        "$HELPER_SCRIPTS/$relative_path"; do
        if [ -f "$script_path" ]; then
            echo "$script_path"
            return 0
        fi
    done

    echo "$relative_path"
}

get_toolset_install_scripts() {
    local toolset_path
    local script_entry
    local tool_name
    local script_path

    toolset_path=$(toolset_config_path) || {
        echo "A toolset.json file is required to install the image toolset." >&2
        return 1
    }

    while IFS=$'\t' read -r tool_name script_path; do
        [ -n "$tool_name" ] || continue
        printf '%s\t%s\n' "$tool_name" "$script_path"
    done < <(
        jq -r 'to_entries[] | select(.value | type == "object") | select(has("install_script")) | select(.install_script != null) | [.key, .install_script] | @tsv' "$toolset_path" | \
        while IFS=$'\t' read -r key relative_path; do
            printf '%s\t%s\n' "$key" "$(resolve_install_script_path "$relative_path")"
        done
    )
}

main() {
    
    printf '==> Starting toolset install\n'

    local tool_name
    local script_path
    local priority_value

    while IFS=$'\t' read -r tool_name script_path; do
        [ -n "$tool_name" ] || continue

        priority_value=1000
        case "$tool_name" in
            cmake) priority_value=0 ;;
            clang) priority_value=1 ;;
            gcc) priority_value=2 ;;
            gfortran) priority_value=3 ;;
            java) priority_value=4 ;;
            android) priority_value=5 ;;
            python) priority_value=6 ;;
            pypy) priority_value=7 ;;
            ruby) priority_value=8 ;;
            node) priority_value=9 ;;
            php) priority_value=10 ;;
            rust) priority_value=11 ;;
            ninja) priority_value=12 ;;
        esac

        printf '%s\t%s\t%s\n' "$priority_value" "$tool_name" "$script_path"
    done < <(get_toolset_install_scripts) | sort -t $'\t' -k1,1n -k2,2 | while IFS=$'\t' read -r _ tool_name script_path; do
        [ -n "$tool_name" ] || continue
        script_count=$((script_count + 1))

        printf '==> Installing tool %s\n' "$tool_name"
        printf '##[section]Installing tool %s\n' "$tool_name"
        printf '##[command]Executing %s\n' "$script_path"
        bash -e "$script_path"
        printf '==> Completed tool %s\n' "$tool_name"
        printf '##[section]Completed tool %s\n' "$tool_name"
    done

    if [ "$script_count" -eq 0 ]; then
        printf '==> No toolset install scripts were selected for this build.\n'
        printf '##[warning]No toolset install scripts selected; skipping tool installation.\n'
    else
        printf '==> Toolset install complete (%s scripts executed).\n' "$script_count"
    fi
}

main "$@"

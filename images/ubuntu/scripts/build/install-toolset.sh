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

    echo "[toolset debug] resolve_install_script_path called with: '$relative_path'" >&2

    if [ -z "$relative_path" ]; then
        echo "[toolset debug] empty relative path; returning failure" >&2
        return 1
    fi

    if [[ "$relative_path" = /* ]]; then
        echo "[toolset debug] absolute path detected: '$relative_path'" >&2
        echo "$relative_path"
        return 0
    fi

    toolset_path=$(toolset_config_path) || toolset_path="${INSTALLER_SCRIPT_FOLDER}/toolset.json"
    echo "[toolset debug] resolved toolset_path for script lookup: '$toolset_path'" >&2
    echo "[toolset debug] dirname(toolset_path)=$(dirname "$toolset_path")" >&2
    echo "[toolset debug] INSTALLER_SCRIPT_FOLDER=${INSTALLER_SCRIPT_FOLDER:-<unset>}" >&2
    echo "[toolset debug] HELPER_SCRIPTS=${HELPER_SCRIPTS:-<unset>}" >&2

    for script_path in \
        "$(dirname "$toolset_path")/$relative_path" \
        "${INSTALLER_SCRIPT_FOLDER}/$relative_path" \
        "${INSTALLER_SCRIPT_FOLDER}/$(basename "$relative_path")" \
        "$HELPER_SCRIPTS/$relative_path"; do
        echo "[toolset debug] candidate script path: '$script_path'" >&2
        if [ -f "$script_path" ]; then
            echo "[toolset debug] found script file: '$script_path'" >&2
            echo "$script_path"
            return 0
        fi
    done

    echo "[toolset debug] no matching script file found, returning original relative path: '$relative_path'" >&2
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

    echo "[toolset debug] loading toolset from: $toolset_path" >&2
    echo "[toolset debug] toolset file exists: $(if [ -f "$toolset_path" ]; then echo yes; else echo no; fi)" >&2
    echo "[toolset debug] toolset file size: $(wc -c < "$toolset_path" 2>/dev/null || echo 0) bytes" >&2

    jq -r 'to_entries[] | select(.value | type == "object") | select(.value.install_script != null) | [.key, .value.install_script] | @tsv' "$toolset_path" | \
        while IFS=$'\t' read -r key relative_path; do
            printf '[toolset debug] raw entry: key=%s relative_path=%s\n' "$key" "$relative_path" >&2
            script_path=$(resolve_install_script_path "$relative_path")
            printf '[toolset debug] resolved script path for %s => %s\n' "$key" "$script_path" >&2
            printf '%s\t%s\n' "$key" "$script_path"
        done
}

main() {
    printf '==> Starting toolset install\n'

    local tool_name
    local script_path
    local priority_value
    local script_count=0
    local sorted_toolset_file

    sorted_toolset_file=$(mktemp)

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
    done < <(get_toolset_install_scripts) | sort -t $'\t' -k1,1n -k2,2 > "$sorted_toolset_file"

    while IFS=$'\t' read -r _ tool_name script_path; do
        [ -n "$tool_name" ] || continue
        script_count=$((script_count + 1))

        printf '==> Installing tool %s\n' "$tool_name"
        printf '##[section]Installing tool %s\n' "$tool_name"
        printf '##[command]Executing %s\n' "$script_path"
        bash -e "$script_path"
        printf '==> Completed tool %s\n' "$tool_name"
        printf '##[section]Completed tool %s\n' "$tool_name"
    done < "$sorted_toolset_file"

    rm -f "$sorted_toolset_file"

    if [ "$script_count" -eq 0 ]; then
        printf '==> No toolset install scripts were selected for this build.\n'
        printf '##[warning]No toolset install scripts selected; skipping tool installation.\n'
    else
        printf '==> Toolset install complete (%s scripts executed).\n' "$script_count"
    fi
}

main "$@"

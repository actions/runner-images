#!/bin/bash
################################################################################
##  File:  php-security.sh
##  Desc:  Validate PHP fixes for CVE-2026-109618 and CVE-2026-109619
################################################################################

php_security_upstream_fixed() {
    local version=${1#*:}
    [[ $version != *~* && ! $version =~ -(dev|alpha|beta|RC|rc)[0-9]*($|[-+]) ]] || return 1
    version=${version%%-*}
    version=${version%%+*}
    [[ $version =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]] || return 1
    local major=$((10#${BASH_REMATCH[1]}))
    local minor=$((10#${BASH_REMATCH[2]}))
    local patch=$((10#${BASH_REMATCH[3]}))
    local minimum

    if ((major > 8 || (major == 8 && minor >= 6))); then
        return 0
    fi
    case "$major.$minor" in
        8.2) minimum=35 ;;
        8.3) minimum=36 ;;
        8.4) minimum=27 ;;
        8.5) minimum=12 ;;
        *) return 1 ;;
    esac
    ((patch >= minimum))
}

php_security_ubuntu_fixed() {
    local release=$1 branch=$2 version=$3 minimum pattern

    # USN-8948-1: accept verified Ubuntu backports without changing PHP APIs.
    # Match the vendor revision family so an unrelated PPA build cannot pass
    # merely because its version sorts above an Ubuntu package.
    case "$release:$branch" in
        22.04:8.1)
            minimum=8.1.2-1ubuntu2.28
            pattern='^8\.1\.2-1ubuntu2\.[0-9]+$'
            ;;
        24.04:8.3)
            minimum=8.3.6-0ubuntu0.24.04.13
            pattern='^8\.3\.6-0ubuntu0\.24\.04\.[0-9]+$'
            ;;
        26.04:8.5)
            minimum=8.5.4-0ubuntu1.5
            pattern='^8\.5\.4-0ubuntu1\.[0-9]+$'
            ;;
        26.10:8.5)
            minimum=8.5.9-0ubuntu2.1
            pattern='^8\.5\.9-0ubuntu2\.[0-9]+$'
            ;;
        *) return 1 ;;
    esac
    [[ $version =~ $pattern ]] && dpkg --compare-versions "$version" ge "$minimum"
}

php_security_check_installed() {
    local packages status package source_package version branch
    local os_id os_version count=0 failed=0
    os_id=$(. /etc/os-release && printf '%s' "$ID") || return 1
    os_version=$(. /etc/os-release && printf '%s' "$VERSION_ID") || return 1
    packages=$(dpkg-query -W '-f=${db:Status-Status}\t${binary:Package}\t${source:Package}\t${Version}\n') || return 1

    while IFS=$'\t' read -r status package source_package version; do
        [[ $status == installed && $source_package =~ ^php([0-9]+\.[0-9]+)$ ]] || continue
        branch=${BASH_REMATCH[1]}
        count=$((count + 1))
        if php_security_upstream_fixed "$version" ||
            { [[ $os_id == ubuntu ]] && php_security_ubuntu_fixed "$os_version" "$branch" "$version"; }; then
            printf 'PHP security check passed: %s %s\n' "$package" "$version"
        else
            printf 'Unverified PHP security fix: %s %s (source %s, %s %s). Update for CVE-2026-109618/109619.\n' \
                "$package" "$version" "$source_package" "$os_id" "$os_version" >&2
            failed=1
        fi
    done <<< "$packages"

    if ((count == 0)); then
        echo 'No installed PHP source packages were found to validate.' >&2
        return 1
    fi
    return "$failed"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
    php_security_check_installed
fi

#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-xcode-clt.sh
##  Desc:  Install Xcode Command Line Tools
################################################################################

source ~/utils/utils.sh

# Optional pin to match the default Xcode, a newer CLT SDK may be unreadable by its linker (e.g. GHC fails to link)
# https://github.com/actions/runner-images/issues/14940
# jq is not built into macOS 14 and is installed later via Homebrew
if ! is_Sonoma; then
    clt_version=$(get_toolset_value '.xcode.command_line_tools // empty')
fi

is_clt_installed() {
    clt_path=$(xcode-select -p 2>&1)
    [[ -d $clt_path ]]
}

install_clt() {
    echo "Searching online for the Command Line Tools"
    # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    sudo touch $clt_placeholder
    cltPattern="Command Line Tools"
    if [[ -n "$clt_version" ]]; then
        # Match the pinned version and its patch releases, e.g. 'Title: Command Line Tools for Xcode, Version: 26.6, ...'
        cltPattern="Command Line Tools.*Version: ${clt_version}[.,]"
    fi

    clt_label_command="/usr/sbin/softwareupdate -l |
                        grep -B 1 -E '${cltPattern}' |
                        awk -F'*' '/^ *\\*/ {print \$2}' |
                        sed -e 's/^ *Label: //' -e 's/^ *//' |
                        sort -V |
                        tail -n1"
    clt_label=$(eval $clt_label_command) || true
    if [[ -n "$clt_label" ]]; then
        echo "Installing $clt_label"
        sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
    fi
    sudo "/bin/rm" "-f" "$clt_placeholder"
}

echo "Installing Command Line Tools${clt_version:+ $clt_version}..."
install_clt

# Retry the installation if tools are not installed from the first attempt
retries=30
sleepInterval=60
while ! is_clt_installed; do
    if [[ $retries -eq 0 ]]; then
        echo "Unable to find the Command Line Tools, all the attempts exhausted"
        exit 1
    fi
    echo "Command Line Tools not found, trying to install them via software updates, $retries attempts left"
    install_clt
    ((retries--))
    echo "Wait $sleepInterval seconds before the next check for installed Command Line Tools"
    sleep $sleepInterval
done

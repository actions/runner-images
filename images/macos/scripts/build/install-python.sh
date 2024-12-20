#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-python.sh
##  Desc:  Install Python
################################################################################

source ~/utils/utils.sh

echo "Installing Python Tooling"

if is_Monterey; then
    echo "Install latest Python 2"
    python2_pkg=$(download_with_retry "https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg")
    python2_pkg_sha256="c570f38b05dd8b112ad21b418cdf51a9816d62f9f44746452739d421be24d50c"
    use_checksum_comparison $python2_pkg $python2_pkg_sha256

    choice_changes_xml=$(mktemp /tmp/python2_choice_changes.xml.XXXXXX)
    sudo installer -showChoiceChangesXML -pkg $python2_pkg -target / | tee $choice_changes_xml > /dev/null

    # To avoid symlink conflicts, remove tools installation in /usr/local/bin using installer choices
    xmllint --shell $choice_changes_xml <<EOF
    cd //array/dict[string[text()='org.python.Python.PythonUnixTools-2.7']]/integer
    set 0
    save
EOF

    sudo installer -applyChoiceChangesXML $choice_changes_xml -pkg $python2_pkg -target /

    pip install --upgrade pip

    echo "Install Python2 certificates"
    bash -c "/Applications/Python\ 2.7/Install\ Certificates.command"
fi

# Close Finder window
close_finder_window

echo "Brew Installing Python 3"
brew_smart_install "python@3.12"

echo "Installing pipx"

if is_Arm64; then
    export PIPX_BIN_DIR="$HOME/.local/bin"
    export PIPX_HOME="$HOME/.local/pipx"
else
    export PIPX_BIN_DIR=/usr/local/opt/pipx_bin
    export PIPX_HOME=/usr/local/opt/pipx
fi

brew_smart_install "pipx"

echo "export PIPX_BIN_DIR=${PIPX_BIN_DIR}" >> ${HOME}/.bashrc
echo "export PIPX_HOME=${PIPX_HOME}" >> ${HOME}/.bashrc
echo 'export PATH="$PIPX_BIN_DIR:$PATH"' >> ${HOME}/.bashrc

invoke_tests "Python"

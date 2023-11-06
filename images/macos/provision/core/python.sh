#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "Installing Python Tooling"

if is_Monterey || is_BigSur; then
    echo "Install latest Python 2"
    Python2Url="https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg"
    download_with_retries $Python2Url "/tmp" "python2.pkg"

    sudo installer -showChoiceChangesXML -pkg /tmp/python2.pkg -target / > /tmp/python2_choices.xml

    # To avoid symlink conflicts, remove tools installation in /usr/local/bin using installer choices
    xmllint --shell /tmp/python2_choices.xml <<EOF
    cd //array/dict[string[text()='org.python.Python.PythonUnixTools-2.7']]/integer
    set 0
    save
EOF

    sudo installer -applyChoiceChangesXML /tmp/python2_choices.xml -pkg /tmp/python2.pkg -target /

    pip install --upgrade pip

    echo "Install Python2 certificates"
    bash -c "/Applications/Python\ 2.7/Install\ Certificates.command"
fi

# Close Finder window
if is_Veertu; then
    close_finder_window
fi

echo "Brew Installing Python 3"
brew_smart_install "python@3.11"

echo "Installing pipx"
export PIPX_BIN_DIR=/usr/local/opt/pipx_bin
export PIPX_HOME=/usr/local/opt/pipx

brew_smart_install "pipx"

echo "export PIPX_BIN_DIR=${PIPX_BIN_DIR}" >> "${HOME}/.bashrc"
echo "export PIPX_HOME=${PIPX_HOME}" >> "${HOME}/.bashrc"
echo 'export PATH="$PIPX_BIN_DIR:$PATH"' >> "${HOME}/.bashrc"

invoke_tests "Python"

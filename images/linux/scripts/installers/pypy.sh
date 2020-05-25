#!/bin/bash
################################################################################
##  File:  pypy.sh
##  Desc:  Installs PyPy
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# This function installs PyPy using the specified arguments:
#   $1=PACKAGE_URL
function InstallPyPy
{
    PACKAGE_URL=$1

    PACKAGE_TAR_NAME=$(echo $PACKAGE_URL | awk -F/ '{print $NF}')
    echo "Downloading tar archive '$PACKAGE_TAR_NAME' - '$PACKAGE_URL'"
    PACKAGE_TAR_TEMP_PATH="/tmp/$PACKAGE_TAR_NAME"
    wget -q -O $PACKAGE_TAR_TEMP_PATH $PACKAGE_URL

    echo "Expand '$PACKAGE_TAR_NAME' to the /tmp folder"
    tar xf $PACKAGE_TAR_TEMP_PATH -C /tmp

    # Get Python version
    PACKAGE_NAME=${PACKAGE_TAR_NAME/.tar.bz2/}
    MAJOR_VERSION=$(echo ${PACKAGE_NAME/pypy/} | cut -d. -f1)
    PYTHON_MAJOR="python$MAJOR_VERSION"

    if [ $MAJOR_VERSION != 2 ]; then
        PYPY_MAJOR="pypy$MAJOR_VERSION"
    else
        PYPY_MAJOR="pypy"
    fi

    PACKAGE_TEMP_FOLDER="/tmp/$PACKAGE_NAME"
    PYTHON_FULL_VERSION=$("$PACKAGE_TEMP_FOLDER/bin/$PYPY_MAJOR" -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))")

    # PyPy folder structure
    PYPY_TOOLCACHE_PATH=$AGENT_TOOLSDIRECTORY/PyPy
    PYPY_TOOLCACHE_VERSION_PATH=$PYPY_TOOLCACHE_PATH/$PYTHON_FULL_VERSION
    PYPY_TOOLCACHE_VERSION_ARCH_PATH=$PYPY_TOOLCACHE_VERSION_PATH/x64

    echo "Check if PyPy hostedtoolcache folder exist..."
    if [ ! -d $PYPY_TOOLCACHE_PATH ]; then
        mkdir -p $PYPY_TOOLCACHE_PATH
    fi

    echo "Create PyPy '$PYPY_TOOLCACHE_VERSION_PATH' folder"
    mkdir $PYPY_TOOLCACHE_VERSION_PATH

    echo "Move PyPy '$PACKAGE_TEMP_FOLDER' binaries to '$PYPY_TOOLCACHE_VERSION_ARCH_PATH' folder"
    mv $PACKAGE_TEMP_FOLDER $PYPY_TOOLCACHE_VERSION_ARCH_PATH

    echo "Create additional symlinks (Required for UsePythonVersion Azure DevOps task)"
    cd $PYPY_TOOLCACHE_VERSION_ARCH_PATH/bin
    ln -s $PYPY_MAJOR $PYTHON_MAJOR
    ln -s $PYTHON_MAJOR python

    chmod +x ./python ./$PYTHON_MAJOR

    echo "Install latest Pip"
    ./python -m ensurepip
    ./python -m pip install --ignore-installed pip

    echo "Create complete file"
    touch $PYPY_TOOLCACHE_VERSION_PATH/x64.complete

    echo "Remove '$PACKAGE_TAR_TEMP_PATH'"
    rm -f $PACKAGE_TAR_TEMP_PATH
}

function getPyPyVersions
{
    uri="https://downloads.python.org/pypy/"
    i=20

    while [ $i -gt 0 ]; do
        ((i--))
        result="$(curl -4 -s --compressed $uri | grep 'linux64' | awk -v uri="$uri" -F'>|<' '{print uri$5}')"
        if [ -z "$result" ]; then
            sleep 30
        else
            echo "$result"
            return
        fi
    done

    echo "There are no more attempts to retrive PyPy version"
    exit 1
}

# Installation PyPy
pypyVersions=$(getPyPyVersions)
toolsetJson="$INSTALLER_SCRIPT_FOLDER/toolset.json"
toolsetVersions=$(cat $toolsetJson | jq -r '.toolcache[] | select(.name | contains("PyPy")) | .versions[]')

# Fail out if any setups fail
set -e

for toolsetVersion in $toolsetVersions; do
    latestMajorPyPyVersion=$(echo "${pypyVersions}" | grep -E "pypy${toolsetVersion}-v[0-9]+\.[0-9]+\.[0-9]+-" | head -1)

    if [[ -z "$latestMajorPyPyVersion" ]]; then
        echo "Failed to get PyPy version '$toolsetVersion'"
        exit 1
    fi

    InstallPyPy $latestMajorPyPyVersion
done

chown -R "$SUDO_USER:$SUDO_USER" "$AGENT_TOOLSDIRECTORY/PyPy"
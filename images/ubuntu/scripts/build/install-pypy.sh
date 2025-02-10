#!/bin/bash -e
################################################################################
##  File:  install-pypy.sh
##  Desc:  Install PyPy
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# This function installs PyPy using the specified arguments:
#   $1=package_url
install_pypy() {
    local package_url=$1

    package_tar_name=$(echo "$package_url" | awk -F/ '{print $NF}')
    package_name=${package_tar_name/.tar.bz2/}

    echo "Downloading tar archive '$package_name'"
    package_tar_temp_path=$(download_with_retry $package_url)

    echo "Expand '$package_name' to the /tmp folder"
    tar xf "$package_tar_temp_path" -C /tmp

    # Get Python version
    major_version=$(echo ${package_name/pypy/} | cut -d. -f1)
    python_major="python$major_version"

    if [ $major_version != 2 ]; then
        pypy_major="pypy$major_version"
    else
        pypy_major="pypy"
    fi

    package_temp_folder="/tmp/$package_name"
    python_full_version=$("$package_temp_folder/bin/$pypy_major" -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))")
    pypy_full_version=$("$package_temp_folder/bin/$pypy_major" -c "import sys;print('{}.{}.{}'.format(*sys.pypy_version_info[0:3]))")
    echo "Put '$pypy_full_version' to PYPY_VERSION file"
    echo $pypy_full_version > "$package_temp_folder/PYPY_VERSION"

    # PyPy folder structure
    pypy_toolcache_path=$AGENT_TOOLSDIRECTORY/PyPy
    pypy_toolcache_version_path=$pypy_toolcache_path/$python_full_version
    pypy_toolcache_version_arch_path=$pypy_toolcache_version_path/x64

    echo "Check if PyPy hostedtoolcache folder exist..."
    if [ ! -d $pypy_toolcache_path ]; then
        mkdir -p $pypy_toolcache_path
    fi

    echo "Create PyPy '$pypy_toolcache_version_path' folder"
    mkdir $pypy_toolcache_version_path

    echo "Move PyPy '$package_temp_folder' binaries to '$pypy_toolcache_version_arch_path' folder"
    mv $package_temp_folder $pypy_toolcache_version_arch_path

    echo "Create additional symlinks (Required for UsePythonVersion Azure DevOps task)"
    cd $pypy_toolcache_version_arch_path/bin

    # Starting from PyPy 7.3.4 these links are already included in the package
    [ -f ./$python_major ] || ln -s $pypy_major $python_major
    [ -f ./python ] || ln -s $python_major python

    chmod +x ./python ./$python_major

    echo "Install latest Pip"
    ./python -m ensurepip
    ./python -m pip install --ignore-installed pip

    echo "Create complete file"
    touch $pypy_toolcache_version_path/x64.complete

    echo "Remove '$package_tar_temp_path'"
    rm -f $package_tar_temp_path
}

# Installation PyPy
pypy_versions_json=$(curl -fsSL https://downloads.python.org/pypy/versions.json)
toolset_versions=$(get_toolset_value '.toolcache[] | select(.name | contains("PyPy")) | .versions[]')

for toolset_version in $toolset_versions; do
    latest_major_pypy_version=$(echo $pypy_versions_json |
        jq -r --arg toolset_version $toolset_version '.[]
        | select((.python_version | startswith($toolset_version)) and .stable == true).files[]
        | select(.arch == "x64" and .platform == "linux").download_url' | head -1)
    if [[ -z "$latest_major_pypy_version" ]]; then
        echo "Failed to get PyPy version '$toolset_version'"
        exit 1
    fi

    install_pypy $latest_major_pypy_version
done

chown -R "$SUDO_USER:$SUDO_USER" "$AGENT_TOOLSDIRECTORY/PyPy"

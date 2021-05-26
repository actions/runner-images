#!/bin/bash -e
################################################################################
##  File:  gcc.sh
##  Desc:  Installs GNU C++
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

function InstallGcc {
    version=$1

    echo "Installing $version..."
    apt-get install $version -y

   # replace the original binaries with the script
   # to make link libstdc++.so to target libstdc++.so.6.0.29
   # not sure it is required for gcc++-9 and gcc++-10
    binary=`which $version`
    mv "$binary" "$binary.orig"
    cat > "$binary" <<EOT
#!/bin/sh

$target=$(basename $(readlink -f /usr/lib/x86_64-linux-gnu/libstdc++.so.6))
if [ $target != libstdc++.so.6.0.29 ];then
 echo "WARNING: your are using $version that requires libstdc++.so.6.0.29"
 echo "         the binaries compiled against it may crash on fresh Ubuntu images"
 ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.29
 echo "         libstdc++.so is a link to libstdc++.so.6.0.29 now"
fi
$binary.orig $@
EOT
    chmod +x "$binary"
}

# apt install of gcc-11 removes the existing
# libstdc++ and replaces it with libstdc++.so.6.0.29
# lets backup the default ubuntu distribution libstdc++
#
# make a copy of libstdc++ on ubuntu 20.04
test -f /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28 && cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28 /tmp
# make a copy of libstdc++ on ubuntu 18.04
test -f /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25 && cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25 /tmp

# Install GNU C++ compiler
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y

versions=$(get_toolset_value '.gcc.versions[]')

for version in ${versions[*]}; do
    InstallGcc $version
done

if [ -f /tmp/libstdc++.so.6.0.25];then
  sudo cp /tmp/libstdc++.so.6.0.25 /usr/lib/x86_64-linux-gnu
  sudo ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25
fi

if [ -f /tmp/libstdc++.so.6.0.28];then
  sudo cp /tmp/libstdc++.so.6.0.28 /usr/lib/x86_64-linux-gnu
  sudo ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28
fi

invoke_tests "Tools" "gcc"

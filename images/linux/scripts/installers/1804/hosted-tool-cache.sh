#!/bin/bash
################################################################################
##  File:  hosted-tool-cache.sh
##  Desc:  Downloads and installs hosted tools cache
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Fail out if any setups fail
set -e

# Download hosted tool cache
AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
echo "AGENT_TOOLSDIRECTORY=$AGENT_TOOLSDIRECTORY" | tee -a /etc/environment
azcopy --recursive \
       --source https://vstsagenttools.blob.core.windows.net/tools/hostedtoolcache/ubuntu-1804 \
       --destination $AGENT_TOOLSDIRECTORY

# Install tools from hosted tool cache
original_directory=$PWD
setups=$(find $AGENT_TOOLSDIRECTORY -name setup.sh)
for setup in $setups; do
	chmod +x $setup;
	cd $(dirname $setup);
	./$(basename $setup);
	cd $original_directory;
done;

DocumentInstalledItem "Python:"
pythons=$(ls $AGENT_TOOLSDIRECTORY/Python)
for python in $pythons; do
	DocumentInstalledItemIndent "Python $python"
	# Add symlinks for python, python2 and python3 so that Python can be used out of the box without setup-python
	if [ ${python:0:3} -eq "2.7" ] ; then
		# add python 2.7 for python and python2
		ln -s $AGENT_TOOLSDIRECTORY/Python/$python/x64/bin/python /usr/local/bin/python
		ln -s $AGENT_TOOLSDIRECTORY/Python/$python/x64/bin/python /usr/local/bin/python2
	elif [ ${python:0:3} -eq "3.6" ] ; then
		# add python 3.6 for python3 which is the default for 1804
		ln -s $AGENT_TOOLSDIRECTORY/Python/$python/x64/bin/python /usr/local/bin/python3
	fi
done;

# PyPy is also configured using the setup-python action
pypys=$(ls $AGENT_TOOLSDIRECTORY/PyPy)
for pypy in $pypys; do
	DocumentInstalledItemIndent "PyPy $pypy"
	# Add symlinks for pypy2 and pypy3 to usr/local/bin, there should only be 2 versions of PyPy in the tools cache that is downloaded
	if [ ${pypy:0:1} -eq "3" ] ; then
		# add pypy 3.X to PATH
		ln -s $AGENT_TOOLSDIRECTORY/PyPy/$pypy/x64/bin/pypy3 /usr/local/bin/pypy3
	else
		# add pypy 2.X to PATH
		ln -s $AGENT_TOOLSDIRECTORY/PyPy/$pypy/x64/bin/pypy /usr/local/bin/pypy
	fi
done;

DocumentInstalledItem "Ruby:"
rubys=$(ls $AGENT_TOOLSDIRECTORY/Ruby)
for ruby in $rubys; do
	DocumentInstalledItemIndent "Ruby $ruby"
done;
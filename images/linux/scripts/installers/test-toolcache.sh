#!/bin/bash
################################################################################
##  File:  test-toolcache.sh
##  Desc:  Test Python and Ruby versions in tools cache
################################################################################

# Must be procecessed after tool cache setup(hosted-tool-cache.sh).

# Fail out if any tests fail
set -e

# defune array of key aliases
key_alias_array=()
bash --version
# define dicionary for key_alias and its values
declare -A toolcache_key_value
PACKAGE_LIST=($(jq -r 'keys | .[]' "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))
for PACKAGE_NAME in ${PACKAGE_LIST[@]}; do

   # get key alias
   key_alias=$(echo $PACKAGE_NAME | cut -f2 -d-)
   echo $key_alias

   # set dictionary
   toolcache_key_value+=(["$key_alias"]="$PACKAGE_NAME")
done;

AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache

# Python test
if [ -d "$AGENT_TOOLSDIRECTORY/Python" ]; then
   cd $AGENT_TOOLSDIRECTORY/Python
   python_dirs=($(find . -mindepth 1 -maxdepth 1 -type d | sed "s|^\./||"))
   echo "Python versions folders: ${python_dirs[@]}"
   echo "------------------------------------------"
   if [ -n "$python_dirs" ]; then
      PACKAGE_VERSIONS=($(jq -r ".[\"${toolcache_key_value[python]}\"] | .[]" "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))
      for python_version in ${PACKAGE_VERSIONS[@]}
      do
         version_dir=$(find . -name "$python_version.*" -print -quit)
         echo "Test $AGENT_TOOLSDIRECTORY/Python/$version_dir:"
         actual_ver=$($AGENT_TOOLSDIRECTORY/Python/$version_dir/x64/python -c 'import sys;print(sys.version)'| head -1 | egrep -o '[0-9]+\.[0-9]+')
         if [ "$actual_ver" = "$python_version" ]; then
               echo "Passed!"
         else
               echo "Expected: $python_version; Actual: $actual_ver"
               exit 1
         fi
      done;
   else
      echo "$AGENT_TOOLSDIRECTORY/Python does not include any folders"
      exit 1
   fi
else
   echo "$AGENT_TOOLSDIRECTORY/Python does not exist"
   exit 1
fi

# Ruby test
if [ -d "$AGENT_TOOLSDIRECTORY/Ruby" ]; then
   cd $AGENT_TOOLSDIRECTORY/Ruby
   ruby_dirs=($(find . -mindepth 1 -maxdepth 1 -type d | sed "s|^\./||"))
   echo "Ruby versions folders: ${ruby_dirs[@]}"
   echo "--------------------------------------"
   if [ -n "$ruby_dirs" ]; then
      PACKAGE_VERSIONS=($(jq -r ".[\"${toolcache_key_value[ruby]}\"] | .[]" "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))
      for ruby_version in ${PACKAGE_VERSIONS[@]}
      do
         version_dir=$(find . -name "$ruby_version.*" -print -quit)
         echo "Test $AGENT_TOOLSDIRECTORY/Ruby/$version_dir:"
         actual_ver=$($AGENT_TOOLSDIRECTORY/Ruby/$version_dir/x64/bin/ruby -e "puts RUBY_VERSION" | egrep -o '[0-9]+\.[0-9]+')
         if [ "$actual_ver" = "$ruby_version" ]; then
               echo "Passed!"
         else
               echo "Expected: $ruby_version; Actual: $actual_ver"
               exit 1
         fi
      done;
   else
      echo "$AGENT_TOOLSDIRECTORY/Ruby does not include any folders"
      exit 1
   fi
else
   echo "$AGENT_TOOLSDIRECTORY/Ruby does not exist"
   exit 1
fi

# PyPy tests
if [ -d "$AGENT_TOOLSDIRECTORY/PyPy" ]; then
   cd $AGENT_TOOLSDIRECTORY/PyPy
   pypy_dirs=($(find . -mindepth 1 -maxdepth 1 -type d | sed "s|^\./||"))
   echo "PyPy versions folders: ${pypy_dirs[@]}"
   echo "------------------------------------------"
   if [ -n "$pypy_dirs" ]; then
      PACKAGE_VERSIONS=($(jq -r ".[\"${toolcache_key_value[pypy]}\"] | .[]" "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))
      for pypy_version in ${PACKAGE_VERSIONS[@]}
      do
         version_dir=$(find . -name "$pypy_version.*" -print -quit)
         pypy_path=$(find . -regex "$version_dir/x64/bin/pypy[0-9]*" -print -quit)
         echo $pypy_path
         actual_ver=$($pypy_path -c 'import sys;print(sys.version)'| head -1 | egrep -o '[0-9]+\.[0-9]+' | cut -d '.' -f 1)
         echo "actual_ver = $actual_ver : pypy_version = $pypy_version"
         if [ "$actual_ver" = "$pypy_version" ]; then
               echo "Passed!"
         else
               echo "Expected: $pypy_version; Actual: $actual_ver"
               exit 1
         fi
      done;
   else
      echo "$AGENT_TOOLSDIRECTORY/PyPy does not include any folders"
      exit 1
   fi
else
   echo "$AGENT_TOOLSDIRECTORY/PyPy does not exist"
   exit 1
fi
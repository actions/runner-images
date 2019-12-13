#!/bin/bash
################################################################################
##  File:  test-toolcache.sh
##  Desc:  Test Python and Ruby versions in tools cache
################################################################################

# Must be procecessed after tool cache setup(hosted-tool-cache.sh).

# Fail out if any tests fail
set -e

AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache

# Python test
if [ -d "$AGENT_TOOLSDIRECTORY/Python" ]; then
   cd $AGENT_TOOLSDIRECTORY/Python
   python_dirs=($(find . -mindepth 1 -maxdepth 1 -type d | sed "s|^\./||"))
   echo "Python versions folders: ${python_dirs[@]}"
   echo "------------------------------------------"
   if [ -n "$python_dirs" ]; then
      for version_dir in "${python_dirs[@]}"
      do
         echo "Test $AGENT_TOOLSDIRECTORY/Python/$version_dir:"
         expected_ver=$(echo $version_dir | egrep -o '[0-9]+\.[0-9]+')
         actual_ver=$($AGENT_TOOLSDIRECTORY/Python/$version_dir/x64/python -c 'import sys;print(sys.version)'| head -1 | egrep -o '[0-9]+\.[0-9]+')

         if [ "$expected_ver" = "$actual_ver" ]; then
               echo "Passed!"
         else
               echo "Expected: $expected_ver; Actual: $actual_ver"
               exit 1
         fi
      done
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
      for version_dir in "${ruby_dirs[@]}"
      do
         echo "Test $AGENT_TOOLSDIRECTORY/Ruby/$version_dir:"
         expected_ver=$(echo $version_dir | egrep -o '[0-9]+\.[0-9]+')
         actual_ver=$($AGENT_TOOLSDIRECTORY/Ruby/$version_dir/x64/bin/ruby -e "puts RUBY_VERSION" | egrep -o '[0-9]+\.[0-9]+')

         if [ "$expected_ver" = "$actual_ver" ]; then
            echo "Passed!"
         else
            echo "Expected: $expected_ver; Actual: $actual_ver"
            exit 1
         fi
      done
   else
      echo "$AGENT_TOOLSDIRECTORY/Ruby does not include any folders"
      exit 1
   fi
else
   echo "$AGENT_TOOLSDIRECTORY/Ruby does not exist"
   exit 1
fi

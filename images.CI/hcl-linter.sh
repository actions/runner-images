#!/bin/bash -e
# This script search .pkr.hcl files in repo and path it thru 'packer validate' linter

file_list=()
exit_codes=()
mapfile -d $'\0' file_list < <(find . -name "*.pkr.hcl" -print0)

for file in "${file_list[@]}"
do
  echo $file
  packer validate -syntax-only $file || exit_codes+=($?)
done

for code in "${exit_codes[@]}"
do
  if [ $code -ne 0 ]
  then
    exit 1
  fi
done
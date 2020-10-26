#!/bin/bash -e

prefix=/usr/local/bin

for tool in apt apt-get apt-fast;do
  rm $prefix/$tool
done

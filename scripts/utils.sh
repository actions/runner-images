#!/bin/bash

set -e

check_env() {
  if [ -z "${!1}" ]; then
    echo "$1 is not set"
    exit 1
  fi
}

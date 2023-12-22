#!/bin/bash

source $HELPER_SCRIPTS/etc-environment.sh

# echo "RUNNER_TOOLCACHE=/opt/hostedtoolcache" | sudo tee -a /etc/environment
setEtcEnvironmentVariable "RUNNER_TOOL_CACHE" "/opt/hostedtoolcache"

# echo "DEPLOYMENT_BASEPATH=/opt/runner" | sudo tee -a /etc/environment
setEtcEnvironmentVariable "DEPLOYMENT_BASEPATH" "/opt/runner"

# echo "RUNNER_PERFLOG=/home/runner/perflog" | sudo tee -a /etc/environment
setEtcEnvironmentVariable "RUNNER_PERFLOG" "/home/runner/perflog"

# echo "RUNNER_USER=runner" | sudo tee -a /etc/environment
setEtcEnvironmentVariable "RUNNER_USER" "runner"

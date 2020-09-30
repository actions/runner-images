#!/bin/bash

# Configure memory cgroups for Hosted Ubuntu
#
# Azure Devops and Github Actions use different names for cgrops and jobs:
# Github Actions - "actions_runner" and "actions_job"
# Azure Devops   - "azpl_agent"     and "azpl_job"
#
# actions_runner/azpl_agent is a group to control actions processes, ie provisioner and runner (agent).
# They have access to 100% of total memory resources so they will never be killed for exceeding cgroup limits
#
# actions_job/azpl_job controls job processes, which is anything downstream of the runner. They have access to 100% of resident memory,
# and all but 3g of total memory + swap. This leaves a buffer for the agent and related processes.
#
# Swap must already be configured for cgroup config to accurately calculate memsw.limit_in_bytes as it is based on /proc/meminfo

set -eux

if [[ "$USER" = "runner" ]]; then
    echo "Github actions naming"
    cgroup_name="actions_runner"
    cgroup_job_name="actions_job"
elif [[ "$USER" = "vsts" ]]; then
    echo "Azure DevOps naming"
    cgroup_name="azpl_agent"
    cgroup_job_name="azpl_job"
else
    echo "the environment is incorrect"
fi

isMntSwap=$(cat /etc/waagent.conf | grep "ResourceDisk.EnableSwap=y" || true)

if [ -z "$isMntSwap" ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi
# Future: These packages are required for this and the warmup_linux scripts to work
# but will be a NOP if already installed on the base image. Can be removed safely once
# the packages are guaranteed to be on the base image.
apt-get install -y libcgroup1 cgroup-tools

# Calculate required memory options
mem_total_in_bytes=$(( $(grep MemTotal /proc/meminfo | awk '{print $2}') * 1024 ))
mem_total_minus1g_in_bytes=$(( mem_total_in_bytes - (1024 * 1024 * 1024) ))
swap_total_in_bytes=$(( $(grep SwapTotal /proc/meminfo | awk '{print $2}') * 1024 ))
total_in_bytes=$(( mem_total_in_bytes + swap_total_in_bytes ))
total_minus2g_in_bytes=$(( total_in_bytes - (2 * 1024 * 1024 * 1024) ))

# Create /etc/cgconfig.conf
echo "group ${cgroup_name} { memory { } }" >> /etc/cgconfig.conf
echo "group ${cgroup_job_name} { memory { memory.limit_in_bytes = ${mem_total_minus1g_in_bytes}; memory.memsw.limit_in_bytes = ${total_minus2g_in_bytes}; } }" >> /etc/cgconfig.conf

# Create /etc/cgrules.conf
echo "root:provisioner memory ${cgroup_name}" >> /etc/cgrules.conf
echo "runner:Runner.Listener memory ${cgroup_name}" >> /etc/cgrules.conf
echo "runner:Runner.Worker memory ${cgroup_name}" >> /etc/cgrules.conf
echo "runner memory ${cgroup_name}" >> /etc/cgrules.conf

# Update Docker daemon conf
if [ ! -f /etc/docker/daemon.json ]; then
    echo "{ "cgroup-parent": "/${cgroup_job_name}" }" > /etc/docker/daemon.json
else
    jq ". + { "cgroup-parent": "/${cgroup_job_name}" }" /etc/docker/daemon.json > daemon_updated.json
    mv daemon_updated.json /etc/docker/daemon.json
fi

# Enable swap accounting
echo 'GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"' > /etc/default/grub.d/40-runner.cfg
update-grub

#!/bin/bash

cd /runner
curl -f -L -o warpbuild-agent.tar.gz https://github.com/WarpBuilds/warpbuild-agent/releases/download/v0.2.1-alpha.2/warpbuild-agentd_Linux_x86_64.tar.gz
mkdir warpbuild-agent/
tar -xzf warpbuild-agent.tar.gz -C warpbuild-agent/
rm warpbuild-agent.tar.gz
cp warpbuild-agent/warpbuild-agentd /usr/local/bin/warpbuild-agentd
chmod +x /usr/local/bin/warpbuild-agentd
cp warpbuild-agent/tools/systemd/warpbuild-agentd.service /etc/systemd/system/warpbuild-agentd.service
chmod +x /runner/warpbuild-agent/tools/github/hooks/prerun.sh
systemctl daemon-reload
systemctl enable warpbuild-agentd.service
systemctl start warpbuild-agentd.service

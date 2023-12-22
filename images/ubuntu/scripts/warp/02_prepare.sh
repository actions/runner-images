#!/bin/bash

waagent -deprovision+user

systemctl disable --now walinuxagent.service
systemctl disable --now walinuxagent-network-setup.service

#cloud init boot up fix to enable other datasources
cloud_init_source=$(cat <<EOL
# to update this file, run dpkg-reconfigure cloud-init
datasource_list: [ NoCloud, ConfigDrive, OpenNebula, DigitalOcean, Azure, AltCloud, OVF, MAAS, GCE, OpenStack, CloudSigma, SmartOS, Bigstep, Scaleway, AliYun, Ec2, CloudStack, Hetzner, IBMCloud, Oracle, Exoscale, RbxCloud, UpCloud, VMware, Vultr, LXD, NWCS, Akamai, None ]
EOL
)
echo "$cloud_init_source" > /etc/cloud/cloud.cfg.d/90_dpkg.cfg

# chrony service fix, time syncronization. disable refclock settings
refclock_text="refclock PHC /dev/ptp_hyperv poll 3 dpoll -2 offset 0"
sed -i "/$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< "$refclock_text")/s/^/#/" /etc/chrony/chrony.conf
systemctl restart chrony

# disable systemd service hyperV kvp daemon
mkdir -p /etc/systemd/system/hv-kvp-daemon.service.d
touch /etc/systemd/system/hv-kvp-daemon.service.d/disable.conf
hv_kvp_daemon_mock=$(cat <<EOL
[Service]
ExecStart=/bin/true
EOL
)
echo "$hv_kvp_daemon_mock" > /etc/systemd/system/hv-kvp-daemon.service.d/disable.conf
systemctl daemon-reload

# remove grub configuration file which is forcing hardcoded bootup grub part UUID
rm /etc/default/grub.d/40-force-partuuid.cfg
update-grub


# fstrim -v /

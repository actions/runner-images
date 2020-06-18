#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -yqq update
apt-get -yqq dist-upgrade
systemctl disable apt-daily.service
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.service

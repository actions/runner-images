#!/bin/bash -e

function killService() {
    service=$1
    systemctl stop $service
    systemctl kill --kill-who=all $service

    # Wait until the status of the service is either exited or killed.
    while ! (systemctl status "$service" | grep "inactive (dead)")
    do
        echo "Wait until status is changed"
        echo $(systemctl status "$service")
        sleep 10
    done
}

function disableTimers() {
    systemctl disable apt-daily.timer
    systemctl disable apt-daily-upgrade.timer
}

function killServices() {
    killService unattended-upgrades.service
    killService apt-daily.service
    killService apt-daily-upgrade.service
}

function main() {
    echo "Disabling timers..."
    disableTimers
    echo "Killing timer services..."
    killServices
}

main
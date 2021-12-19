#!/bin/bash -e

# Put snapd auto refresh on hold
# as it may generate too much traffic on Canonical's snap server
# when they are rolling a new major update out.
# Hold is calculated as today's date + 60 days

snap set system refresh.hold="$(date --date='today+60 days' +%Y-%m-%dT%H:%M:%S%:z)"

#!/bin/bash -e
################################################################################
##  File:  configure-dpkg.sh
##  Desc:  Configure dpkg
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
# This is the anti-frontend. It never interacts with you  at  all,
# and  makes  the  default  answers  be used for all questions. It
# might mail error messages to root, but that's it;  otherwise  it
# is  completely  silent  and  unobtrusive, a perfect frontend for
# automatic installs. If you are using this front-end, and require
# non-default  answers  to questions, you will need to pre-seed the
# debconf database
set_etc_environment_variable "DEBIAN_FRONTEND" "noninteractive"

# dpkg can be instructed not to ask for confirmation
# when replacing a configuration file (with the --force-confdef --force-confold options)
# --force-unsafe-io drops the fsync calls dpkg makes while unpacking packages. Runner VMs are
# ephemeral, so trading crash consistency for faster package installation is acceptable here
cat <<EOF >> /etc/apt/apt.conf.d/10dpkg-options
Dpkg::Options {
  "--force-confdef";
  "--force-confold";
  "--force-unsafe-io";
}
EOF

# hide information about packages that are no longer required
cat <<EOF >> /etc/apt/apt.conf.d/10apt-autoremove
APT::Get::AutomaticRemove "0";
APT::Get::HideAutoRemove "1";
EOF

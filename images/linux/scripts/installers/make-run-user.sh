#!/bin/bash -e
################################################################################
##  File:  make-run-user.sh
##  Desc:  Create /run/user/<runner user id> directory as the pam_systemd did.
##         We need to do this here because the agent runs the shell script
##         by passing PAM subsytem but some apps (like snap) expect pam_systemd
##         to make this directore to store user's tmp files
################################################################################

runtmp="/run/user/$(id -u)"
sudo mkdir $runtmp
sudo chown `whoami` $runtmp
sudo chgrp `whoami` $runtmp
sudo chmod 770 $runtmp

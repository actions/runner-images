#!/bin/bash -e
################################################################################
##  File:  post-build-validation.sh
##  Desc:  Validate different aspects of the image after build
################################################################################

echo "Test microsoft defender not installed using '-d /opt/microsoft/mdatp'"
# Validate Defender not installed test 1
if [ -d /opt/microsoft/mdatp ]; then
    echo "Microsoft Defender for Endpoint is installed."
    exit 1
fi

echo "Test microsoft defender not installed using 'systemctl list-units --type=service --all | grep mdatp'"
# Validate Defender not installed test 2
if systemctl list-units --type=service --all | grep -w mdatp &>/dev/null; then
    echo "Microsoft Defender for Endpoint is installed."
    exit 1
fi

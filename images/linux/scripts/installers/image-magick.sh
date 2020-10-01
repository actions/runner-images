#!/bin/bash
################################################################################
##  File:  image-magick.sh
##  Desc:  Installs ImageMagick
################################################################################

set -e
set -o pipefail

# Install ImageMagick
apt-get install -y --no-install-recommends --fix-missing \
    imagemagick \
    libmagickcore-dev \
    libmagickwand-dev \
    libmagic-dev

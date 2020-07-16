#!/bin/bash
################################################################################
##  File:  image-magick.sh
##  Desc:  Installs ImageMagick
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install ImageMagick
apt-get install -y --no-install-recommends --fix-missing \
    imagemagick \
    libmagickcore-dev \
    libmagickwand-dev \
    libmagic-dev

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "ImageMagick"

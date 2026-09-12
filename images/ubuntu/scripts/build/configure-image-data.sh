#!/bin/bash -e
################################################################################
##  File:  configure-image-data.sh
##  Desc:  Create a file with image data and documentation links
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh

imagedata_file=$IMAGEDATA_FILE
image_version=$IMAGE_VERSION
image_version_major=${image_version/.*/}
image_version_minor=$(echo $image_version | cut -d "." -f 2)
os_name=$(lsb_release -ds | sed "s/ /\\\n/g")
os_version=$(lsb_release -rs)
version_major=${os_version/.*/}
version_wo_dot=${os_version/./}
github_url="https://github.com/actions/runner-images/blob"

image_label=$(select_by_arch "ubuntu-${os_version}" "ubuntu-${os_version}-arm")
software_url=$(select_by_arch \
  "${github_url}/ubuntu${version_major}/${image_version_major}.${image_version_minor}/images/ubuntu/Ubuntu${version_wo_dot}-Readme.md" \
  "${github_url}/ubuntu${version_major}-arm64/${image_version_major}.${image_version_minor}/images/ubuntu/Ubuntu${version_wo_dot}-Arm64-Readme.md")
releaseUrl=$(select_by_arch \
  "https://github.com/actions/runner-images/releases/tag/ubuntu${version_major}%2F${image_version_major}.${image_version_minor}" \
  "https://github.com/actions/runner-images/releases/tag/ubuntu${version_major}-arm64%2F${image_version_major}.${image_version_minor}")

cat <<EOF > $imagedata_file
[
  {
    "group": "Operating System",
    "detail": "${os_name}"
  },
  {
    "group": "Runner Image",
    "detail": "Image: ${image_label}\nVersion: ${image_version}\nIncluded Software: ${software_url}\nImage Release: ${releaseUrl}"
  }
]
EOF

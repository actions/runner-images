#!/bin/bash -e

imagedata_file=$IMAGEDATA_FILE
image_version=$IMAGE_VERSION
os_name=$(lsb_release -ds | sed "s/ /\\\n/g")
image_label="ubuntu-$(lsb_release -rs)"
github_url="https://github.com/actions/virtual-environments/blob"

if [[ "$image_label" =~ "ubuntu-20" ]]; then
    software_url="${github_url}/ubuntu20/${image_version}/images/linux/Ubuntu2004-Readme.md"
    releaseUrl="https://github.com/actions/virtual-environments/releases/tag/ubuntu20%2F${image_version}"
fi

if [[ "$image_label" =~ "ubuntu-18" ]]; then
    software_url="${github_url}/ubuntu18/${image_version}/images/linux/Ubuntu1804-Readme.md"
    releaseUrl="https://github.com/actions/virtual-environments/releases/tag/ubuntu18%2F${image_version}"
fi

cat <<EOF > $imagedata_file
[
  {
    "group": "Operating System",
    "detail": "${os_name}"
  },
  {
    "group": "Virtual Environment",
    "detail": "Environment: ${image_label}\nVersion: ${image_version}\nIncluded Software: ${software_url}\nImage Release: ${releaseUrl}"
  }
]
EOF

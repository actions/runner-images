#!/bin/bash -e

imagedata_file=$IMAGEDATA_FILE
image_version=$IMAGE_VERSION
image_version_major=${image_version/.*/}
image_version_minor=$(echo $image_version | cut -d "." -f 2)
os_name=$(lsb_release -ds | sed "s/ /\\\n/g")
os_version=$(lsb_release -rs)
image_label="ubuntu-${os_version}"
version_major=${os_version/.*/}
version_wo_dot=${os_version/./}
github_url="https://github.com/actions/runner-images/blob"

software_url="${github_url}/ubuntu${version_major}/${image_version_major}.${image_version_minor}/images/linux/Ubuntu${version_wo_dot}-Readme.md"
releaseUrl="https://github.com/actions/runner-images/releases/tag/ubuntu${version_major}%2F${image_version_major}.${image_version_minor}"

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

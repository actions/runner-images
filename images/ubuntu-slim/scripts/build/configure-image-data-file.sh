#!/bin/bash -e

function create_imagedata_json() {

  arch=$(uname -m)
  if [[ $arch == "x86_64" ]]; then
    arch="x64"
  elif [[ $arch == "aarch64" ]]; then
    arch="arm64"
  else
    echo "Unsupported architecture: $arch"
    exit 1
  fi

  if [[ -n "$IMAGEDATA_INCLUDED_SOFTWARE" ]]; then
    included_software="- Included Software: ${IMAGEDATA_INCLUDED_SOFTWARE}"
  fi

  imagedata_file="/imagegeneration/imagedata.json"

  cat <<EOF > $imagedata_file
[
  {
    "group": "VM Image",
    "detail": "- OS: Linux (${arch})\n- Source: Docker\n- Name: ${IMAGEDATA_NAME}\n- Version: ${IMAGE_VERSION}\n${included_software}"
  }
]
EOF

}

mkdir -p /imagegeneration

# Generate the imagedata JSON file displayed on workflow initialization
if [[ -n "$IMAGEDATA_NAME" ]]; then
  echo "Generating imagedata JSON file"
  create_imagedata_json
else
  echo "IMAGEDATA_NAME is null or empty. Skipping imagedata JSON generation."
fi
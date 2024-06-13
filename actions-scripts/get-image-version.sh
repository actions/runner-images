#!/bin/bash
# Read the README_PATH from parameter
README_PATH="$1"

# Read the content of the README file
if [ -f "$README_PATH" ]; then
    content=$(cat "$README_PATH")
else
    echo "README file not found."
    exit 1
fi

# Extract the image version
version=$(echo "$content" | grep -oP 'Image Version:\s*\K\S+')

# Check if a version was found
if [ -n "$version" ]; then
    echo "Image Version: $version"
    # Set the environment variable
    echo "IMAGE_VERSION=$version" >> $GITHUB_ENV
else
    echo "Image version not found."
    exit 1
fi

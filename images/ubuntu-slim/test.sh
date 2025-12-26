#!/bin/bash -e

# This script builds and runs various tests on the ubuntu-slim Docker image
# to ensure it contains the expected software and configurations.
# The build and test workflows for docker images expect this script to be present.
#
# Usage: test.sh [IMAGE_NAME]
# If IMAGE_NAME is not provided, defaults to ubuntu-slim:test

show_help() {
    echo "Usage: $0 [IMAGE_NAME]"
    echo ""
    echo "Test a Docker image to ensure it contains the expected software and configurations."
    echo ""
    echo "Arguments:"
    echo "  IMAGE_NAME    Docker image name to test (default: ubuntu-slim:test)"
    echo ""
    echo "Examples:"
    echo "  $0                           # Test ubuntu-slim:test (builds image first)"
    echo "  $0 my-registry/ubuntu:latest # Test existing image"
    echo "  $0 ubuntu-slim:v1.2.3        # Test tagged image"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
}

# Handle help flags
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Set the image name from parameter or use default
IMAGE_NAME="${1:-ubuntu-slim:test}"

echo "Testing image: $IMAGE_NAME"

run_test() {
    local desc="$1"
    shift
    if output=$(docker run --rm "$IMAGE_NAME" "$@" 2>&1); then
        echo "PASS: $desc"
        echo "$output" | sed 's/^/    /'
    else
        echo "FAIL: $desc"
        echo "$output" | sed 's/^/    /'
        exit 1
    fi
}

# Build the image only if using the default name (for backward compatibility)
if [[ "$IMAGE_NAME" == "ubuntu-slim:test" ]]; then
    echo "Building image: $IMAGE_NAME"
    if ! docker build --no-cache --debug --progress plain -t "$IMAGE_NAME" .; then
        echo "Error: Docker build failed"
        exit 1
    fi
else
    # Check if the image exists
    if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
        echo "Error: Image '$IMAGE_NAME' does not exist. Please build it first or provide a valid image name."
        echo "Run '$0 --help' for usage information."
        exit 1
    fi
fi

echo "Running tests on image: $IMAGE_NAME"

docker history --no-trunc "$IMAGE_NAME"
docker inspect -f "{{ .Size }}" "$IMAGE_NAME" | numfmt --to=iec | sed 's/^/Image size: /'

# Ensure key software is installed and runnable
run_test "GitHub CLI is installed" gh --version
run_test "Azure CLI is installed" az version
run_test "AWS CLI is installed" aws --version
run_test "Session Manager plugin is installed" session-manager-plugin --version
run_test "AWS SAM CLI is installed" sam --version
run_test "jq is installed" jq --version
run_test "git is installed" git --version
run_test "node is installed" node --version
run_test "npm is installed" npm --version
run_test "python3 is installed" python3 --version
run_test "python is aliased" python --version
run_test "pipx is installed" pipx --version
run_test "curl is installed" curl --version
run_test "wget is installed" wget --version
run_test "yq is installed" yq --version
run_test "parallel is installed" parallel --version
run_test "bc is installed" bc --version
run_test "zstd is installed" zstd --version
run_test "google cloud SDK is installed" gcloud --version
run_test "git lfs is installed" git lfs version
run_test "powershell is installed" pwsh --version

# Quick check: ensure the imagedata JSON file was created during image build
run_test "imagedata JSON file exists" test -f /imagegeneration/imagedata.json

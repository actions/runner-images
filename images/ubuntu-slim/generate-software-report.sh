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
    echo "Generate a software report for a Docker image."
    echo ""
    echo "Arguments:"
    echo "  IMAGE_NAME    Docker image name to generate report for (default: ubuntu-slim:test)"
    echo ""
    echo "Examples:"
    echo "  $0                           # Generate report for ubuntu-slim:test (builds image first)"
    echo "  $0 my-registry/ubuntu:latest # Generate report for existing image"
    echo "  $0 ubuntu-slim:v1.2.3        # Generate report for tagged image"
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

# Build the image only if using the default name (for backward compatibility)
if [[ "$IMAGE_NAME" == "ubuntu-slim:test" ]]; then
    echo "Building image: $IMAGE_NAME"
    docker build --debug --progress plain -t "$IMAGE_NAME" .
else
    # Check if the image exists
    if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
        echo "Error: Image '$IMAGE_NAME' does not exist. Please build it first or provide a valid image name."
        echo "Run '$0 --help' for usage information."
        exit 1
    fi
fi

echo "Generating software report for image: $IMAGE_NAME"

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd ../../helpers/software-report-base && pwd)"

echo $BASE_DIR

# Create a temporary directory for output
OUTPUT_DIR=$(mktemp -d)
echo "Using temporary directory: $OUTPUT_DIR"

# Run the container and execute the PowerShell script inside it
echo "Running Generate-SoftwareReport.ps1 inside the container..."
docker run --rm \
    -v "$OUTPUT_DIR:/output" \
    -v "$SCRIPT_DIR/scripts/docs-gen:/scripts/docs-gen:ro" \
    -v "$BASE_DIR:/scripts/software-report-base:ro" \
    "$IMAGE_NAME" \
    pwsh /scripts/docs-gen/Generate-SoftwareReport.ps1 -OutputDirectory /output

if [ -f "$OUTPUT_DIR/software-report.md" ]; then
    cp "$OUTPUT_DIR/software-report.md" ubuntu-slim-Readme.md
    echo "✓ Copied software-report.md to current directory"
else
    echo "✗ Error: software-report.md was not generated"
    rm -rf "$OUTPUT_DIR"
    exit 1
fi

# Clean up temporary directory
rm -rf "$OUTPUT_DIR"
echo "✓ Software report generation complete"

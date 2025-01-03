#!/bin/bash

# Script to build and run Runner Images for Ubuntu 24.04 and Windows Server 2025 debugging
# with Clang setup

# Variables
UBUNTU_IMAGE_NAME="runner-images-ubuntu-24.04"
WINDOWS_IMAGE_NAME="runner-images-windows-2025"
CONTAINER_NAME="runner-images-container"
UBUNTU_DOCKERFILE_PATH="./Dockerfile.ubuntu"  # Adjust if Dockerfile for Ubuntu is in a different location
WINDOWS_DOCKERFILE_PATH="./Dockerfile.windows"  # Adjust if Dockerfile for Windows is in a different location
CONTEXT_DIR="."                # Adjust if the context is a different directory
WORKSPACE_DIR="$(pwd)"         # Current directory as the workspace
UBUNTU_CLANGFILE_PATH="clangfile.ubuntu.json"
WINDOWS_CLANGFILE_PATH="clangfile.windows.json"
LOG_FILE="runner-images-build.log"

# Functions

# Cleanup Function
cleanup() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Cleaning up any existing container with the same name..."
    if docker rm -f ${CONTAINER_NAME} 2>/dev/null; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Container ${CONTAINER_NAME} successfully removed."
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] No container named ${CONTAINER_NAME} found or removal failed."
    fi
}

# Build Image Function
build_image() {
    local image_name="$1"
    local dockerfile_path="$2"
    local clangfile_path="$3"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Building Docker image: ${image_name}..."
    if docker build -t ${image_name} -f ${dockerfile_path} --build-arg CLANGFILE=${clangfile_path} ${CONTEXT_DIR} | tee -a ${LOG_FILE}; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Docker image ${image_name} built successfully."
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: Docker image build for ${image_name} failed. Check ${LOG_FILE} for details."
        exit 1
    fi
}

# Run Container Function
run_container() {
    local image_name="$1"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Running Docker container: ${CONTAINER_NAME} for ${image_name}..."
    docker run -it --rm \
        --name ${CONTAINER_NAME} \
        --mount type=bind,source=${WORKSPACE_DIR},target=/workspace \
        --network none \  # Ensures no network access for isolation
        ${image_name}
    if [ $? -eq 0 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Container ${CONTAINER_NAME} for ${image_name} ran successfully."
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: Failed to run container ${CONTAINER_NAME} for ${image_name}."
        exit 1
    fi
}

# Main Execution Workflow
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Starting Runner Image Setup for Ubuntu 24.04 and Windows Server 2025 with Clang configurations..."

# Clean up any previous runs
cleanup

# Build the Ubuntu Docker image with Clang configuration
build_image ${UBUNTU_IMAGE_NAME} ${UBUNTU_DOCKERFILE_PATH} ${UBUNTU_CLANGFILE_PATH}

# Run the Ubuntu container
run_container ${UBUNTU_IMAGE_NAME}

# Build the Windows Docker image with Clang configuration
build_image ${WINDOWS_IMAGE_NAME} ${WINDOWS_DOCKERFILE_PATH} ${WINDOWS_CLANGFILE_PATH}

# Run the Windows container
run_container ${WINDOWS_IMAGE_NAME}

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Runner Image Setup for both Ubuntu 24.04 and Windows Server 2025 with Clang configurations completed."

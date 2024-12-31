#!/bin/bash

# Script to build and run the Runner Image for Windows Server 2025 debugging

# Variables
IMAGE_NAME="runner-images-windows-2025"
CONTAINER_NAME="runner-images-container"
DOCKERFILE_PATH="./Dockerfile"  # Adjust if Dockerfile is in a different location
CONTEXT_DIR="."                # Adjust if the context is a different directory
WORKSPACE_DIR="$(pwd)"         # Current directory as the workspace

# Functions
function build_image() {
    echo "Building Docker image: ${IMAGE_NAME}..."
    docker build -t ${IMAGE_NAME} -f ${DOCKERFILE_PATH} ${CONTEXT_DIR}
}

function run_container() {
    echo "Running Docker container: ${CONTAINER_NAME}..."
    docker run -it --rm \
        --name ${CONTAINER_NAME} \
        --mount type=bind,source=${WORKSPACE_DIR},target=/workspace \
        --network none \  # Ensures no network access for isolation
        ${IMAGE_NAME}
}

function cleanup() {
    echo "Cleaning up any existing container with the same name..."
    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
}

# Main execution
cleanup
build_image
run_container

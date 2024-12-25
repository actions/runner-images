#!/bin/bash -e

# Check if EXTERNALLY-MANAGED environment variable is set
if [ -n "$EXTERNALLY-MANAGED" ]; then
    echo "Skipping installation of Python packages due to EXTERNALLY-MANAGED environment variable"
    exit 0
fi

# Your existing script for installing Python packages goes here

#!/bin/bash
# /opt/entrypoint.sh

# Load environment variables from file
set -a
source /etc/environment
set +a

# Execute the actual command
exec "$@"
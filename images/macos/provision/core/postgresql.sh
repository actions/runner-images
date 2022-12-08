#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Fetch PostgreSQL version to install from the toolset
toolsetVersion=$(get_toolset_value '.postgresql.version')

# Install latest version of PostgreSQL
brew_smart_install postgresql@$toolsetVersion

# Service PostgreSQL should be started before use
postgreService=$(brew services list | grep -oe "postgresql\S*")
brew services start $postgreService

# Verify PostgreSQL is ready for accept incoming connections
echo "Check PostgreSQL service is running"
i=10
COMMAND='pg_isready'
while [ $i -gt 0 ]; do
    echo "Check PostgreSQL service status"
    eval $COMMAND && break
    ((i--))
    if [ $i == 0 ]; then
        echo "PostgreSQL service not ready, all attempts exhausted"
        exit 1
    fi
    echo "PostgreSQL service not ready, wait 10 more sec, attempts left: $i"
    sleep 10
done

# Stop PostgreSQL
brew services stop $postgreService

invoke_tests "Databases" "PostgreSQL"

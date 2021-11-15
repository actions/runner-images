# !/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Fetch postgresql version to install from the toolset
toolsetVersion=$(get_toolset_value '.postgresql.version')

# Search for the latest version of the postgresql corresponding to version from the toolset
versionToInstall=$(brew search /postgresql@$toolsetVersion/ | awk -F' ' '{print $1}' | tail -1)

# Install latest version of postgresql
brew_smart_install $versionToInstall

# Service postgresql should be started before use
brew services start postgresql

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

# Stop postgresql
brew services stop postgresql

invoke_tests "Databases" "PostgreSQL"

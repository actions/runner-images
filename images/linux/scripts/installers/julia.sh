#!/bin/bash
################################################################################
##  File:  julia.sh
##  Desc:  Installs Julia, and adds Julia to the path
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# This function installs Julia using the specified arguments:
#   $1=MajorVersion (1.3)
#   $2=MajorAndMinorVersion (1.3.1)
#   $3=IsDefaultVersion (true or false)

function InstallJulia () {
    curl -sL "https://julialang-s3.julialang.org/bin/linux/x64/$1/julia-$2-linux-x86_64.tar.gz" -o "julia-$2-linux-x86_64.tar.gz"
    mkdir -p "/usr/local/julia$1"
    tar -C "/usr/local/julia$1" -xzf "julia-$2-linux-x86_64.tar.gz" --strip-components=1 julia
    rm "julia-$2-linux-x86_64.tar.gz"

    # If this version of Julia is to be the default version,
    # symlink it into the path
    if [ "$3" = true ]; then
        ln -s "/usr/local/julia$1/bin/julia" /usr/bin/julia
    fi

    # Run tests to determine that the software installed as expected
    echo "Testing to make sure that script performed as expected, and basic scenarios work"

    # If this version of Julia is to be the default version,
    # check that it has been added to PATH
    if [ "$3" = true ]; then
        if ! command -v julia; then
            echo "Julia was not installed or found on PATH"
            exit 1
        fi
    fi

    # Verify output of julia --version
    if [ ! "$(/usr/local/julia"$1"/bin/julia --version)" = "julia version $2" ]; then
        echo "Julia was not installed correctly"
        exit 1
    fi

    # Document what was added to the image
    echo "Lastly, documenting what we added to the metadata file"
    DocumentInstalledItem "Julia ($(julia --version))"
}

InstallJulia 1.3 1.3.1 true

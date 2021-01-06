#!/bin/bash -e
################################################################################
##  File:  julia.sh
##  Desc:  Installs Julia, and adds Julia to the path
################################################################################

# This function fetches the latest Julia release from the GitHub API
# Based on https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
function GetLatestJuliaRelease () {
    curl --silent "https://api.github.com/repos/julialang/julia/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    sed 's/v//' # remove v prefix
}

juliaVersion="$(GetLatestJuliaRelease)"
juliaMajorAndMinorVersion="$(cut -d. -f1,2 <<< $juliaVersion)"
juliaInstallationPath="/usr/local/julia$juliaVersion"

curl -sL "https://julialang-s3.julialang.org/bin/linux/x64/$juliaMajorAndMinorVersion/julia-$juliaVersion-linux-x86_64.tar.gz" -o "julia-$juliaVersion-linux-x86_64.tar.gz"
mkdir -p "$juliaInstallationPath"
tar -C "$juliaInstallationPath" -xzf "julia-$juliaVersion-linux-x86_64.tar.gz" --strip-components=1
rm "julia-$juliaVersion-linux-x86_64.tar.gz"

ln -s "$juliaInstallationPath/bin/julia" /usr/bin/julia

invoke_tests "Tools" "Julia"

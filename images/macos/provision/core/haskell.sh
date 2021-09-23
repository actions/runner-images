#!/bin/bash -e -o pipefail

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
export PATH="$HOME/.ghcup/bin:$PATH"
echo 'export PATH="$PATH:$HOME/.ghcup/bin"' >> "$HOME/.bashrc"

# ghcup output looks like this "ghc 8.6.4 base-4.12.0.0 hls-powered", need to take all the first versions only(8.6.4 in that case) and avoid pre-release ones
availableVersions=$(ghcup list -t ghc -r | grep -v "prerelease" | awk '{print $2}')

# Install 3 latest major versions(For instance 8.6.5, 8.8.4, 8.10.2)
minorMajorVersions=$(echo "$availableVersions" | cut -d"." -f 1,2 | uniq | tail -n3)
for majorMinorVersion in $minorMajorVersions; do
    fullVersion=$(echo "$availableVersions" | grep "$majorMinorVersion." | tail -n1)
    echo "install ghc version $fullVersion..."
    ghcup install $fullVersion
    ghcup set $fullVersion

    # remove docs and profiling libs
    ghc_dir="$(ghcup whereis basedir)/ghc/$fullVersion"
    [ -e "${ghc_dir}" ] || exit 1
    find "${ghc_dir}" \( -name "*_p.a" -o -name "*.p_hi" \) -type f -delete
    rm -r "${ghc_dir}"/share/*
    unset ghc_bin_dir ghc_dir
done

echo "install cabal..."
ghcup install-cabal

invoke_tests "Haskell"

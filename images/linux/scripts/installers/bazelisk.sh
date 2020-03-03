################################################################################
##  File:  bazelisk.sh
##  Desc:  Install Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install bazelisk
npm install -g @bazel/bazelisk

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v bazelisk; then
    echo "Bazelisk was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Bazelisk ($(bazelisk version))"
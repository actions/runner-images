#!/bin/bash -e -o pipefail

invoke_tests() {
    local TEST_FILE="$1"
    local TEST_NAME="$2"

    source $HOME/.bashrc
    pwsh -Command "Import-Module '$HOME/image-generation/helpers/Tests.Helpers.psm1' -DisableNameChecking
        Invoke-PesterTests -TestFile \"$TEST_FILE\" -TestName \"$TEST_NAME\""
}

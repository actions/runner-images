#!/bin/bash -e

source $HELPER_SCRIPTS/Tests.Helpers.psm1

invoke_pester_tests() {
    local TEST_FILE="$1"
    local TEST_NAME="$2"

    pwsh -Command "Invoke-PesterTests -TestFile $TEST_FILE -TestName $TEST_NAME"
}
#!/bin/bash -e
################################################################################
##  File:  invoke-tests.sh
##  Desc:  Helper function for invoking tests
################################################################################

invoke_tests() {
    local TEST_FILE="$1"
    local TEST_NAME="$2"

    pwsh -Command "Import-Module '$HELPER_SCRIPTS/Tests.Helpers.psm1' -DisableNameChecking
        Invoke-PesterTests -TestFile \"$TEST_FILE\" -TestName \"$TEST_NAME\""
}
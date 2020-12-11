#!/bin/bash -e
################################################################################
##  File:  invoke-tests.sh
##  Desc:  Helper function for invoking tests
################################################################################

pwsh -Command "Import-Module (Join-Path $PSScriptRoot 'SoftwareReport.Helpers.psm1') -DisableNameChecking"

invoke_pester_tests() {
    local TEST_FILE="$1"
    local TEST_NAME="$2"

    pwsh -Command "Invoke-PesterTests -TestFile $TEST_FILE -TestName $TEST_NAME"
}
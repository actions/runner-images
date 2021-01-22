#!/bin/bash -e
################################################################################
##  File:  invoke-tests.sh
##  Desc:  Helper function for invoking tests
################################################################################

pwsh -Command "Import-Module '$HELPER_SCRIPTS/Tests.Helpers.psm1' -DisableNameChecking
    Invoke-PesterTests -TestFile \"$1\" -TestName \"$2\""

#!/bin/bash -e -o pipefail

source $HOME/.bashrc

pwsh -Command "Import-Module '$HELPER_SCRIPTS/Tests.Helpers.psm1' -DisableNameChecking
    Invoke-PesterTests -TestFile \"$1\" -TestName \"$2\""

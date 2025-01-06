#!/bin/bash -e -o pipefail

source $HOME/.bashrc
pwsh -Command "Import-Module '$HOME/image-generation/tests/Helpers.psm1' -DisableNameChecking
        Invoke-PesterTests -TestFile \"$1\" -TestName \"$2\""

Import-Module "$HELPER_SCRIPTS/Tests.Helpers.psm1" -DisableNameChecking

Invoke-PesterTests "*"
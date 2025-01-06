Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

Invoke-PesterTests "*"

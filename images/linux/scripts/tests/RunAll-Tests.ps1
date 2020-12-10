Import-Module (Join-Path $PSScriptRoot "Tests.Helpers.psm1") -DisableNameChecking

Invoke-PesterTests "*"
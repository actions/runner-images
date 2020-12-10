Import-Module (Join-Path $PSScriptRoot "Tests.Helpers.psm1") -DisableNameChecking

Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "azcopy" {
    It "azcopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }

    It "azcopy10" {
        "azcopy10 --version" | Should -ReturnZeroExitCode
    }
}

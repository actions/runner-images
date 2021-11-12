Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "SwiftLint" {
    It "SwiftLint" {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}
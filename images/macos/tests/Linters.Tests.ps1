Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "SwiftLint" {
    It "SwiftLint" -Skip:($os.IsHighSierra) {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}
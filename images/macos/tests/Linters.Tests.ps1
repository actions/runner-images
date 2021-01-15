Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Linters" {
    It "SwiftLint" -Skip:($os.IsHighSierra) {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}
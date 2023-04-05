Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "SwiftLint" -Skip:($os.IsVenturaArm64) {
    It "SwiftLint" {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}
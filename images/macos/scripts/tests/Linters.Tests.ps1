Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "SwiftLint" -Skip:($os.IsArm64) {
    It "SwiftLint" {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}

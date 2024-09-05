Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "SwiftLint" -Skip:($os.IsVenturaArm64 -or $os.IsSonomaArm64 -or $os.IsSequoiaArm64) {
    It "SwiftLint" {
        "swiftlint version" | Should -ReturnZeroExitCode
    }
}

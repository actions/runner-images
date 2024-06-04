Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Git" {
    It "git is installed" {
        "git --version" | Should -ReturnZeroExitCode
    }
    It "git lfs is installed" -Skip:($os.IsBigSur) {
        "git lfs version" | Should -ReturnZeroExitCode
    }
}

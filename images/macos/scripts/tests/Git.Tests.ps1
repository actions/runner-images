Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Git" {
    It "git is installed" {
        "git --version" | Should -ReturnZeroExitCode
    }
    It "git lfs is installed" -Skip:($os.IsBigSur) {
        "git lfs version" | Should -ReturnZeroExitCode
    }
    It "GIT_CLONE_PROTECTION_ACTIVE environment variable should be equal false" {
        $env:GIT_CLONE_PROTECTION_ACTIVE | Should -BeExactly false
    }
}

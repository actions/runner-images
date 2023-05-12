Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
$os = Get-OSVersion
Describe "Git" {
    It "git is installed" {
        "git --version" | Should -ReturnZeroExitCode
    }
    It "git lfs is installed" {
        "git lfs version" | Should -ReturnZeroExitCode
    }
}
Describe "hub CLI" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "hub CLI is installed" {
        "hub --version" | Should -ReturnZeroExitCode
    }
}
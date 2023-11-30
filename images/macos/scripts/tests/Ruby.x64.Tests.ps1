Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Ruby" -Skip:($os.IsArm64) {
    It "Ruby is available" {
        "ruby --version" | Should -ReturnZeroExitCode
    }

    It "Ruby is installed via HomeBrew" {
        Get-ToolPath "ruby" | Should -Not -BeLike "/usr/bin/ruby*"
    }

    It "Ruby tools are consistent" {
        $expectedPrefix = "/usr/local"
        Get-ToolPath "ruby" | Should -Match "$($expectedPrefix)*"
        Get-ToolPath "gem" | Should -Match "$($expectedPrefix)*"
        Get-ToolPath "bundler" | Should -Match "$($expectedPrefix)*"
    }

    It "Ruby gems permissions are valid" {
        "gem install bundle" | Should -ReturnZeroExitCode
        "gem uninstall bundle" | Should -ReturnZeroExitCode
    }
}

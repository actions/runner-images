Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "PHP" {
    Context "PHP" -Skip:($os.IsArm64) {
        It "PHP Path" {
            Get-ToolPath "php" | Should -Not -BeLike "/usr/bin/php*"
        }
        It "PHP version" {
            $phpVersionToolset = (Get-ToolsetContent).php.version
            $phpInstalledVersion = php --version | Out-String | Select-String "${phpVersionToolset}"
            $phpInstalledVersion | Should -BeLike "PHP ${phpVersionToolset}*"
        }
    }

    Context "Composer" -Skip:($os.IsArm64) {
        It "Composer" {
            "composer --version" | Should -ReturnZeroExitCode
        }
    }
}

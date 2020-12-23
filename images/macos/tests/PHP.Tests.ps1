Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"


Describe "PHP" {
    Context "PHP" {
        It "php" {
            Get-WhichTool "php" | Should -Not -BeLike "/usr/bin/php*"
            "php --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Composer" {
        It "Composer" {
            "composer --version" | Should -ReturnZeroExitCode
        }
    }
}


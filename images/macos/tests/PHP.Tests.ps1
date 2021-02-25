Describe "PHP" {
    Context "PHP" {
        It "PHP Path" {
            Get-WhichTool "php" | Should -Not -BeLike "/usr/bin/php*"
        }
        It "PHP version" {
            "php --version" | Should -ReturnZeroExitCode
        }
    }
    Context "Composer" {
        It "Composer" {
            "composer --version" | Should -ReturnZeroExitCode
        }
    }
}
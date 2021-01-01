Describe "PHP" {

    [array]$testCases = (Get-ToolsetContent).php.versions | ForEach-Object { @{phpVersion = $_} }

    It "php <phpVersion>" -TestCases $testCases {
        param (
            [string] $phpVersion
        )

        "php$phpVersion --version" | Should -ReturnZeroExitCode
        "php-config$phpVersion --version" | Should -ReturnZeroExitCode
        "phpize$phpVersion --version" | Should -ReturnZeroExitCode
    }

    It "PHPUnit" {
        "phpunit --version" | Should -ReturnZeroExitCode
    }

    It "Composer" {
        "composer --version" | Should -ReturnZeroExitCode
    }

    It "Pear" {
        "pear" | Should -ReturnZeroExitCode
    }

    It "Pecl" {
        "pecl" | Should -ReturnZeroExitCode
    }
}
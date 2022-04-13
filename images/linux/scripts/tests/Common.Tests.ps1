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

Describe "Swift" {
    It "swift" {
        "swift --version" | Should -ReturnZeroExitCode
    }

    It "swiftc" {
        "swiftc --version" | Should -ReturnZeroExitCode
    }
}

Describe "PipxPackages" {
    [array]$testCases = (Get-ToolsetContent).pipx | ForEach-Object { @{package=$_.package; cmd = $_.cmd} }

    It "<package>" -TestCases $testCases {
        "$cmd --version" | Should -ReturnZeroExitCode
    }
}

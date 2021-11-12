Describe "PHP" {
    It "Check PHP version" {
        $phpMajorMinor = (Get-ToolsetContent).php.version
        "php --version" | Should -BeLike "*${phpMajorMinor}*"
    }

    It "Check Composer in the PATH" {
        "composer --version" | Should -ReturnZeroExitCode
    }

    It "PHP Environment variables is set." {
        ${env:PHPROOT} | Should -Not -BeNullOrEmpty
        ${env:PHPROOT} | Should -Exist
    }
}

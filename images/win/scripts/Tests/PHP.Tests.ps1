Describe "PHP" {
    It "Check <ToolName> in the PATH" -TestCases @(
        @{ ToolName = "php" }
        @{ ToolName = "composer" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }

    It "PHP Environment variables is set." {
        Get-EnvironmentVariable "PHPROOT" | Should -Not -BeNullOrEmpty
    }
}
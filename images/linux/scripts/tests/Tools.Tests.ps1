Import-Module "/imagegeneration/helpers/Tests.Helpers.psm1" -DisableNameChecking

Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "azcopy" }
        @{ ToolName = "azcopy10" }
    ) {
        "$ToolName --version"| Should -ReturnZeroExitCode
    }
}
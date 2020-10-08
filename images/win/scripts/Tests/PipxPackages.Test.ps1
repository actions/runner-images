Describe "yamllint" {
    It "yamllint" {
        "yamllint --version" | Should -ReturnZeroExitCode
    }
}
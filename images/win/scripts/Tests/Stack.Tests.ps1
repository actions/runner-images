Describe "Stack" {
    It "Stack exists" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

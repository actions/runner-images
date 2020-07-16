Describe "Typescript" {
    It "tsc exists" {
        "tsc --version" | Should -ReturnZeroExitCode
    }
}

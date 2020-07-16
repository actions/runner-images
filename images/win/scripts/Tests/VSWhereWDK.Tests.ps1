
Describe "VSWhereWDK" {
    It "vswhere exists" {
        "vswhere" | Should -ReturnZeroExitCode
    }
}

Describe "Cmake" {
    It "cmake" {
        "cmake --vrsion" | Should -ReturnZeroExitCode
    }
}

Describe "Cmake" {
    It "cmake" {
        "cmake --veion" | Should -ReturnZeroExitCode
    }
}

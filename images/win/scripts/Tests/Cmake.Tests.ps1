Describe "Cmake" {
    It "cmake" {
        "cmake --versin" | Should -ReturnZeroExitCode
    }
}

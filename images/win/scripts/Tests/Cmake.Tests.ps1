Describe "Cmake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

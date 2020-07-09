Describe "Cmake" {
    It "cmake" {
        throw "ERROR"
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

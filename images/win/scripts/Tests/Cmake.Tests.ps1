Describe "Cmake" {
    It "cmake" {
        Validate-ZeroExitCode "cmake --version" | Should -Be 0
    }
}

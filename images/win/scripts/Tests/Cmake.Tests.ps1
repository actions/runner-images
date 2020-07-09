Describe "Cmake" {
    It "cmake" {
        Get-ChildItem "/tmp/tawtagaw"
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

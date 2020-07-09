Describe "Cmake" {
    It "cmake" {
        Get-ChildItem "/tmp/waaawgaw"
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

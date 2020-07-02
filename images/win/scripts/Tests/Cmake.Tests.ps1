Describe "Cmake" {
    It "cmake2" {
        "cmake --version" | Should -ReturnZeroExitCode
    }

    It "cmake" {
        Get-WhichTool "cmake" | Should -Not -BeNullOrEmpty
        Write-Host (Get-WhichTool "cmake")
    }
}

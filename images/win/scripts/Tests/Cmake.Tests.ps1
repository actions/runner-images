Describe "Cmake" {
    It "cmake2" {
        "cmake --version" | Shoule -ShouldReturnZeroExitCode
    }

    It "cmake" {

        Write-Host (Get-WhichTool "cmake")
    }
}

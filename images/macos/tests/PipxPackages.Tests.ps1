Describe "PipxPackages" {
    $pipxToolset = Get-ToolsetValue "pipx"
    $testCases = $pipxToolset | ForEach-Object { @{package = $_.package; cmd = $_.cmd} }
    It "<package>" -TestCases $testCases {
        "$cmd" | Should -ReturnZeroExitCode
    }
}
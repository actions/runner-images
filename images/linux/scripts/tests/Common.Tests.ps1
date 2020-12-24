Describe "PipxPackages" {
    $pipxToolset = Get-ToolsetValue "pipx"
    $testCases = $pipxToolset | ForEach-Object { @{package = $_.package; cmd = $_.cmd} }
    It "<package>" -TestCases $testCases {
        "$cmd  --version" | Should -ReturnZeroExitCode
    }
}

Describe "Swift" {
    It "swift" {
        "swift --version" | Should -ReturnZeroExitCode
    }

    It "swiftc" {
        "swiftc --version" | Should -ReturnZeroExitCode
    }
}

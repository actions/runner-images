Describe "Node.js" {
    $binaries = @("node")
    $toolsetContent = Get-ToolsetContent
    $module_commands = @(
        $toolsetContent.node_modules.packages |
        Where-Object { $_ -and $_.command } |
        ForEach-Object { $_.command }
    )
    $testCases = @($binaries + $module_commands) |
        Where-Object { $_ } |
        ForEach-Object { @{NodeCommand = $_} }

    It "<NodeCommand>" -TestCases $testCases {
        "$NodeCommand --version" | Should -ReturnZeroExitCode
    }

    It "Node.js version should correspond to the version in the toolset" {
        node --version | Should -BeLike "v$($toolsetContent.node.default).*"
    }
}

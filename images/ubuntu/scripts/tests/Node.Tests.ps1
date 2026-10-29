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
        $expectedNodeVersion = [string]$toolsetContent.node.default
        $actualNodeVersion = (node --version).Trim()

        if ($expectedNodeVersion -match '^\d+\.\d+\.\d+$') {
            $actualNodeVersion | Should -Be "v$expectedNodeVersion"
        } else {
            $actualNodeVersion | Should -BeLike "v$expectedNodeVersion.*"
        }
    }
}

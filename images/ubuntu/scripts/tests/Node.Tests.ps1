Describe "Node.js" {
    $binaries = @("node")
    $module_commands = (Get-ToolsetContent).node_modules | ForEach-Object { $_.command }
    $testCases = $binaries + $module_commands | ForEach-Object { @{NodeCommand = $_} }

    It "<NodeCommand>" -TestCases $testCases {
        param (
            [string] $NodeCommand
        )

        "$NodeCommand --version" | Should -ReturnZeroExitCode
    }

    It "Node.js version should correspond to the version in the toolset" {
        node --version | Should -BeLike "v$((Get-ToolsetContent).node.default).*"
    }
}


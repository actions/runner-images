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
}


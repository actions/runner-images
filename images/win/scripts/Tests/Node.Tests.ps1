Describe "Node.JS" {
    Context "Basic modules"{
        It "<ToolName> " -TestCases @(
            @{ ToolName = "node" }
            @{ ToolName = "npm" }
        ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }
    Context "Global NPM Packages"  {
        $testCases = @(
            @{ ToolName = "yarn" }
            @{ ToolName = "lerna" }
            @{ ToolName = "newman" }
        )
        if (Test-IsWin16 -or Test-IsWin19) {
            $testCases += @(
                @{ ToolName = "gulp" }
                @{ ToolName = "grunt" }
            )
        }
        It "<ToolName> " -TestCases $testCases {
            "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }
}
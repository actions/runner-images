Describe "Node LTS" {
    It "Checking <ToolName> " -TestCases @(
        @{ ToolName = "node" }
        @{ ToolName = "npm" }
        @{ ToolName = "gulp" }
        @{ ToolName = "grunt" }
        @{ ToolName = "yarn" }
        @{ ToolName = "lerna" }
        @{ ToolName = "newman" }
    ) {
       "$ToolName --version" | Should -ReturnZeroExitCode
    }
}
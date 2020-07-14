Describe "Node.JS" {
    It "<ToolName> " -TestCases @(
        @{ ToolName = "node" }
        @{ ToolName = "npm" }
    ) {
       "$ToolName --version" | Should -ReturnZeroExitCode
    }
    It "<ToolName> " -TestCases @(
        @{ ToolName = "gulp" }
        @{ ToolName = "grunt" }
        @{ ToolName = "yarn" }
        @{ ToolName = "lerna" }
        @{ ToolName = "newman" }
    ) {
       "$ToolName --version" | Should -ReturnZeroExitCode
    }
}
Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}
Describe "MySQL CLI" {
    It "Checking MySQL CLI" {
        "mysql -V" | Should -ReturnZeroExitCode
    } 
}


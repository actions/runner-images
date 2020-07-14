Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}
Describe "MySQL" {
    It "Checking MySQL CLI" {
        "mysql -V" | Should -ReturnZeroExitCode
    } 
}


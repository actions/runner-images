Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        $toolsetVersion = Get-ToolsetValue 'mongodb.version'
        (&$ToolName --version)[2].Split('"')[-2] | Should -BeLike "$toolsetVersion*"
    }
}

Describe "PostgreSQL" {
    It "PostgreSQL-Client" {
        "psql --version" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL-Server" {
        "pg_config --version" | Should -ReturnZeroExitCode
    }
}
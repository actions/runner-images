Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        $toolsetVersion = (Get-ToolsetContent).mongodb.version
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
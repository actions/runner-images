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
    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = Get-ToolsetValue 'postgresql.version'
        # Client version
        (psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        # Server version
        (pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
    }
}
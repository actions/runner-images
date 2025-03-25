Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "MongoDB" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        $toolsetVersion = (Get-ToolsetContent).mongodb.version
        (&$ToolName --version)[2].Split('"')[-2] | Should -BeLike "$toolsetVersion*"
    }
}

Describe "PostgreSQL" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = (Get-ToolsetContent).postgresql.version
        # Client version
        (psql --version).split()[-2] | Should -BeLike "$toolsetVersion*"
        # Server version
        (pg_config --version).split()[-2] | Should -BeLike "$toolsetVersion*"
    }

    It "PostgreSQL common operations" {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        "psql -c 'CREATE DATABASE testdb;'" | Should -ReturnZeroExitCode
        "psql -d testdb -c 'CREATE TABLE testtable (id SERIAL PRIMARY KEY, name VARCHAR(50));'" | Should -ReturnZeroExitCode
        "psql -d testdb -c 'INSERT INTO testtable (name) VALUES (''testname'');'" | Should -ReturnZeroExitCode
        "psql -d testdb -c 'SELECT * FROM testtable;'" | Should -ReturnZeroExitCode
        "psql -d testdb -c 'DROP TABLE testtable;'" | Should -ReturnZeroExitCode
        "psql -c 'DROP DATABASE testdb;'" | Should -ReturnZeroExitCode
        "sudo systemctl stop postgresql" | Should -ReturnZeroExitCode
    }
}

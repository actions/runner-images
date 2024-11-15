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
}

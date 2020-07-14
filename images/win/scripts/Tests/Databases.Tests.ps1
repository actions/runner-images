Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}

Describe "PostgreSQL" {
    $psqlTests = @(
        @{envVar = "PGBIN"; pgPath = Get-EnvironmentVariable "PGBIN"}
        @{envVar = "PGROOT"; pgPath = Get-EnvironmentVariable "PGROOT"}
        @{envVar = "PGDATA"; pgPath = Get-EnvironmentVariable "PGDATA"}
    )

    Context "Environment variable" {
        It "PGUSER contains postgres" {
            Get-EnvironmentVariable "PGUSER" | Should -Be "postgres"
        }

        It "PGPASSWORD contains root" {
            Get-EnvironmentVariable "PGPASSWORD" | Should -Be "root"
        }

        It "<envVar> environment variable exists" -TestCases $psqlTests {
            Get-EnvironmentVariable $envVar | Should -Not -BeNullOrEmpty
        }
    }

    Context "Path" {
        It "<pgPath> path exists" -TestCases $psqlTests {
            $pgPath | Should -Exist
        }
    }

    Context "Service" {
        It "PostgreSQL service is stopped" {
            (Get-Service -Name postgresql*).Status | Should -Be "Stopped"
        }

        It "PostgreSQL service is disabled" {
            (Get-Service -Name postgresql*).StartType | Should -Be "Disabled"
        }
    }
}
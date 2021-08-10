Describe "MongoDB" {
    It "mongodb" {
        "mongo --version" | Should -ReturnZeroExitCode
        "mongod --version"| Should -ReturnZeroExitCode
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
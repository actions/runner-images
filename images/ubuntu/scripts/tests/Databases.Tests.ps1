Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "PostgreSQL" {
    It "PostgreSQL Service" -Skip:(Test-IsDockerContainer) {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        "pg_isready" | Should -OutputTextMatchingRegex "/var/run/postgresql:5432 - accepting connections"
        "sudo systemctl stop postgresql" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = (Get-ToolsetContent).postgresql.version
        # Client version
        (psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        # Server version
        if (-not (Test-IsDockerContainer)) {
            (pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        }
    }

    It "PostgreSQL client development tools" {
        # Without a server, pg_config reports the independently versioned libpq-dev.
        "pg_config --version" | Should -ReturnZeroExitCode
        Test-Path "$(pg_config --includedir)/libpq-fe.h" | Should -BeTrue
    }
}

Describe "MySQL" {
    It "MySQL CLI" {
        "mysql -V" | Should -ReturnZeroExitCode
    }

    It "MySQL Service" -Skip:(Test-IsDockerContainer) {
        "sudo systemctl start mysql" | Should -ReturnZeroExitCode
        mysql -s -N -h localhost -uroot -proot -e "select count(*) from mysql.user where user='root' and authentication_string is null;" | Should -BeExactly 0
        "sudo mysql -vvv -e 'CREATE DATABASE smoke_test' -uroot -proot" | Should -ReturnZeroExitCode
        "sudo mysql -vvv -e 'DROP DATABASE smoke_test' -uroot -proot" | Should -ReturnZeroExitCode
        "sudo systemctl stop mysql" | Should -ReturnZeroExitCode
    }
}

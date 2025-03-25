Describe "MongoDB" -Skip:(-not (Test-IsUbuntu20)) {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        $toolsetVersion = (Get-ToolsetContent).mongodb.version
        (& $ToolName --version)[2].Split('"')[-2] | Should -BeLike "$toolsetVersion*"
    }
}

Describe "PostgreSQL" {
    It "PostgreSQL Service" {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        "pg_isready" | Should -OutputTextMatchingRegex "/var/run/postgresql:5432 - accepting connections"
        "sudo systemctl stop postgresql" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = (Get-ToolsetContent).postgresql.version
        # Client version
        (psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        # Server version
        (pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
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

Describe "MySQL" {
    It "MySQL CLI" {
        "mysql -V" | Should -ReturnZeroExitCode
    }

    It "MySQL Service" {
        "sudo systemctl start mysql" | Should -ReturnZeroExitCode
        mysql -s -N -h localhost -uroot -proot -e "select count(*) from mysql.user where user='root' and authentication_string is null;" | Should -BeExactly 0
        "sudo mysql -vvv -e 'CREATE DATABASE smoke_test' -uroot -proot" | Should -ReturnZeroExitCode
        "sudo mysql -vvv -e 'DROP DATABASE smoke_test' -uroot -proot" | Should -ReturnZeroExitCode
        "sudo systemctl stop mysql" | Should -ReturnZeroExitCode
    }
}

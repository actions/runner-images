Describe "Cassandra" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "cassandra" }
    ) {
        $toolsetVersion = (Get-ToolsetContent).cassandra.version
        (&$ToolName -v).split()[-1] | Should -BeLike "$toolsetVersion*"
    }

    It "CQLSH validation" {
        # Cassandra Query Language (CQL) Shell version
        $cqlshVersion = (Get-ToolsetContent).cassandra.cqlsh
        (cqlsh --version).split()[-1] | Should -BeLike "cqlsh $cqlshVersion*"
    }
}

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
    It "PostgreSQL Service" {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        "pg_isready" | Should -MatchCommandOutput "/var/run/postgresql:5432 - accepting connections"
        "sudo systemctl stop postgresql" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = (Get-ToolsetContent).postgresql.version
        # Client version
        (psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        # Server version
        (pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
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

    It "MySQL sysVinit script works" {
        sudo /etc/init.d/mysql start | Out-Null
        systemctl is-active mysql | Should -Be "active"
        sudo /etc/init.d/mysql stop | Out-Null
        systemctl is-active mysql | Should -Be "inactive"
    }
}

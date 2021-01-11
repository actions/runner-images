Describe "MongoDB" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}

Describe "PostgreSQL" {

    It "PostgreSQL Service" {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        (Get-CommandResult "pg_isready").Output | Should -Be "/var/run/postgresql:5432 - accepting connections"
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

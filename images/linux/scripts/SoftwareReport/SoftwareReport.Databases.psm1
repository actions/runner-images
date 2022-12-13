function Get-PostgreSqlVersion {
    $postgreSQLVersion = psql --version | Take-OutputPart -Part 2
    return "PostgreSQL $postgreSQLVersion"
}

function Get-MongoDbVersion {
    $mongoDBVersion = mongod --version | Select-Object -First 1 | Take-OutputPart -Part 2 -Delimiter "v"
    return "MongoDB $mongoDBVersion"
}

function Get-SqliteVersion {
    $sqliteVersion = sqlite3 --version | Take-OutputPart -Part 0
    return "sqlite3 $sqliteVersion"
}

function Get-MySQLVersion {
    $mySQLVersion = mysqld --version | Take-OutputPart -Part 2
    if (Test-IsUbuntu18) {
        $mySQLVersion = $mySQLVersion | Take-OutputPart -Part 0 -Delimiter "-"
    }
    return "MySQL $mySQLVersion"
}

function Get-SQLCmdVersion {
    $sqlcmdVersion = sqlcmd -? | Select-String -Pattern "Version" | Take-OutputPart -Part 1
    return "sqlcmd $sqlcmdVersion"
}

function Get-SqlPackageVersion {
    $sqlPackageVersion = sqlpackage /version
    return "SqlPackage $sqlPackageVersion"
}

function Build-PostgreSqlSection {
    $output = ""

    $output += New-MDHeader "PostgreSQL" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-PostgreSqlVersion)
    )
    $output += New-MDCode -Lines @(
        "User: postgres",
        "PostgreSQL service is disabled by default.",
        "Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'"
    )

    return $output
}

function Build-MySQLSection {
    $output = ""

    $output += New-MDHeader "MySQL" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-MySQLVersion )
    )
    $output += New-MDCode -Lines @(
        "User: root",
        "Password: root",
        "MySQL service is disabled by default.",
        "Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'"
    )

    return $output
}

function Build-MSSQLToolsSection {
    $output = ""

    $output += New-MDHeader "MS SQL Server Client Tools" -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        (Get-SQLCmdVersion),
        (Get-SqlPackageVersion)
    )

    return $output
}

function Get-PostgreSqlVersion {
    $postgreSQLVersion = psql --version | Take-OutputPart -Part 2
    return $postgreSQLVersion
}

function Get-MongoDbVersion {
    $mongoDBVersion = mongod --version | Select-Object -First 1 | Take-OutputPart -Part 2 -Delimiter "v"
    return $mongoDBVersion
}

function Get-SqliteVersion {
    $sqliteVersion = sqlite3 --version | Take-OutputPart -Part 0
    return $sqliteVersion
}

function Get-MySQLVersion {
    $mySQLVersion = mysqld --version | Take-OutputPart -Part 2
    if (Test-IsUbuntu18) {
        $mySQLVersion = $mySQLVersion | Take-OutputPart -Part 0 -Delimiter "-"
    }
    return $mySQLVersion
}

function Get-SQLCmdVersion {
    $sqlcmdVersion = sqlcmd -? | Select-String -Pattern "Version" | Take-OutputPart -Part 1
    return $sqlcmdVersion
}

function Get-SqlPackageVersion {
    $sqlPackageVersion = sqlpackage /version
    return $sqlPackageVersion
}

function Build-PostgreSqlSection {
    $node = [HeaderNode]::new("PostgreSQL")
    $node.AddToolVersion("PostgreSQL", $(Get-PostgreSqlVersion))
    $node.AddNote(@(
        "User: postgres",
        "PostgreSQL service is disabled by default.",
        "Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'"
    ) -join "`n")

    return $node
}

function Build-MySQLSection {
    $node = [HeaderNode]::new("MySQL")
    $node.AddToolVersion("MySQL", $(Get-MySQLVersion))
    $node.AddNote(@(
        "User: root",
        "Password: root",
        "MySQL service is disabled by default.",
        "Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'"
    ) -join "`n")

    return $node
}

function Build-MSSQLToolsSection {
    $node = [HeaderNode]::new("MS SQL")
    $node.AddToolVersion("sqlcmd", $(Get-SQLCmdVersion))
    $node.AddToolVersion("SqlPackage", $(Get-SqlPackageVersion))
    return $node
}

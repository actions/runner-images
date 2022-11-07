using module ./../helpers/SoftwareReport.Helpers.psm1

function Get-PostgreSqlVersion {
    $postgreSQLVersion = psql --version | Take-OutputPart -Part 2
    $aptSourceRepo = Get-AptSourceRepository -PackageName "postgresql"
    return "PostgreSQL $postgreSQLVersion (apt source repository: $aptSourceRepo)"
}

function Get-MongoDbVersion {
    $mongoDBVersion = mongod --version | Select-Object -First 1 | Take-OutputPart -Part 2 -Delimiter "v"
    $aptSourceRepo = Get-AptSourceRepository -PackageName "mongodb"
    return "MongoDB $mongoDBVersion (apt source repository: $aptSourceRepo)"
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
    param (
        [ArchiveItems] $Archive
    )

    $output = ""

    $output += New-MDHeader $Archive.SetHeader("PostgreSQL", 4) -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        $Archive.Add((Get-PostgreSqlVersion), "PostgreSql"),
        $Archive.Add("PostgreSQL Server (user:postgres)", "PostgreSqlServer")
    )
    $output += New-MDCode -Lines @(
        "PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'"
    )

    return $output
}

function Build-MySQLSection {
    param (
        [ArchiveItems] $Archive
    )

    $output = ""

    $output += New-MDHeader $Archive.SetHeader("MySQL", 4) -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        $Archive.Add((Get-MySQLVersion), "MySql"),
        $Archive.Add("MySQL Server (user:root password:root)", "MySqlServer")
    )
    $output += New-MDCode -Lines @(
        "MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'"
    )

    return $output
}

function Build-MSSQLToolsSection {
    param (
        [ArchiveItems] $Archive
    )

    $output = ""

    $output += New-MDHeader $Archive.SetHeader("MS SQL Server Client Tools", 4) -Level 4
    $output += New-MDList -Style Unordered -Lines @(
        $Archive.Add((Get-SQLCmdVersion), "SqlCmd"),
        $Archive.Add((Get-SqlPackageVersion), "SqlPackage")
    )

    return $output
}

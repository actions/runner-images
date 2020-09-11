function Get-PostgreSqlVersion {
    $postgreSQLVersion = psql --version | Take-Part -Part 2
    return "Postgre SQL $postgreSQLVersion"
}

function Get-MongoDbVersion {
    $mongoDBVersion = mongod --version | Select-Object -First 1 | Take-Part -Part 2 -Delimiter "v"
    return "MongoDB $mongoDBVersion"
}

function Get-SqliteVersion {
    $sqliteVersion = sqlite3 --version | Take-Part -Part 0
    return "sqlite3 $sqliteVersion"
}

function Get-MySqlVersion {
    $mySqlVersion = (mysql --version).Split("/usr/bin/")[1]
    return "MySQL ($mySqlVersion)"
}
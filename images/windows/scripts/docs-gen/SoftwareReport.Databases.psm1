function Get-PostgreSQLTable
{
    $pgService = Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'"
    $pgPath = $pgService.PathName
    $pgRoot = $pgPath.split('"')[1].replace("\bin\pg_ctl.exe", "")
    $env:Path += ";${env:PGBIN}"
    $pgVersion = (postgres --version).split()[2].Trim()

    return @(
        [PSCustomObject]@{ Property = "ServiceName"; Value = $pgService.Name },
        [PSCustomObject]@{ Property = "Version"; Value = $pgVersion },
        [PSCustomObject]@{ Property = "ServiceStatus"; Value = $pgService.State },
        [PSCustomObject]@{ Property = "ServiceStartType"; Value = $pgService.StartMode },
        [PSCustomObject]@{ Property = "EnvironmentVariables"; Value = "`PGBIN=$env:PGBIN` <br> `PGDATA=$env:PGDATA` <br> `PGROOT=$env:PGROOT` " },
        [PSCustomObject]@{ Property = "Path"; Value = $pgRoot },
        [PSCustomObject]@{ Property = "UserName"; Value = $env:PGUSER },
        [PSCustomObject]@{ Property = "Password"; Value = $env:PGPASSWORD }
    )
}

function Get-MongoDBTable
{
    $name = "MongoDB"
    if (Test-IsWin25) {
        $command = "mongod"
    } else {
        $command = "mongo"
    }
    $mongoService = Get-Service -Name $name
    $mongoVersion = (Get-Command -Name $command).Version.ToString()
    return [PSCustomObject]@{
        Version = $mongoVersion
        ServiceName = $name
        ServiceStatus = $mongoService.Status
        ServiceStartType = $mongoService.StartType
    }
}

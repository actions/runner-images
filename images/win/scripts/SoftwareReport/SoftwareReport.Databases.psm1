function Get-PostgreSQLSection
{
    $name = "PostgreSQL"
    $headerNode = [HeaderNode]::new($name)
    $pgService = Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'"
    $pgPath = $pgService.PathName
    $pgRoot = $pgPath.split('"')[1].replace("\bin\pg_ctl.exe", "")
    $env:Path += ";${env:PGBIN}"
    $pgVersion = (postgres --version).split()[2].Trim()

    $content = @(
        [PSCustomObject]@{ Property = "ServiceName"; Value = $pgService.Name },
        [PSCustomObject]@{ Property = "Version"; Value = $pgVersion },
        [PSCustomObject]@{ Property = "ServiceStatus"; Value = $pgService.State },
        [PSCustomObject]@{ Property = "ServiceStartType"; Value = $pgService.StartMode },
        [PSCustomObject]@{ Property = "EnvironmentVariables"; Value = "`PGBIN=$env:PGBIN` <br> `PGDATA=$env:PGDATA` <br> `PGROOT=$env:PGROOT` " },
        [PSCustomObject]@{ Property = "Path"; Value = $pgRoot },
        [PSCustomObject]@{ Property = "UserName"; Value = $env:PGUSER },
        [PSCustomObject]@{ Property = "Password"; Value = $env:PGPASSWORD }
    )

    $headerNode.AddTable($content)

    return $headerNode
}

function Get-MongoDBSection
{
    $name = "MongoDB"
    $headerNode = [HeaderNode]::new($name)
    $mongoService = Get-Service -Name $name
    $mongoVersion = (Get-Command -Name 'mongo').Version.ToString()
    $content = [PSCustomObject]@{
        Version = $mongoVersion
        ServiceName = $name
        ServiceStatus = $mongoService.Status
        ServiceStartType = $mongoService.StartType
    }

    $headerNode.AddTable($content)

    return $headerNode
}

function Build-DatabasesSection {
    return @(
        ($(Get-PostgreSQLSection)),
        ($(Get-MongoDBSection))
    )
}
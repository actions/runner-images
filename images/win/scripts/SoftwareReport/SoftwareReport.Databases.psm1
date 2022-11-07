using module ./SoftwareReport.Helpers.psm1

function Get-PostgreSQLMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $name = "PostgreSQL"
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

    $Archive.SetHeader($name, 4) | Out-Null
    $content | ForEach-Object { $Archive.Add("$($_.Property)|$($_.Value)", "$($name)_$($_.Property)") } | Out-Null

    $contentMdTable = $content | New-MDTable
    Build-MarkdownElement -Head $name -Content $contentMdTable
}

function Get-MongoDBMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $name = "MongoDB"
    $mongoService = Get-Service -Name $name
    $mongoVersion = (Get-Command -Name 'mongo').Version.ToString()
    $content = [PSCustomObject]@{
        Version = $mongoVersion
        ServiceName = $name
        ServiceStatus = $mongoService.Status
        ServiceStartType = $mongoService.StartType
    }

    $Archive.SetHeader($name, 4) | Out-Null
    $Archive.Add("$($content.Version)|$($content.ServiceName)|$($content.ServiceStatus)|$($content.ServiceStartType)", $name) | Out-Null

    $contentMdTable = $content | New-MDTable
    Build-MarkdownElement -Head $name -Content $contentMdTable
}

function Build-DatabasesMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $markdown = ""
    $markdown += Get-PostgreSQLMarkdown $Archive
    $markdown += Get-MongoDBMarkdown $Archive
    $markdown
}
function Get-PostgreSQLMarkdown
{
    $name = "PostgreSQL"
    $pgService = Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'"
    $pgPath = $pgService.PathName
    $pgRoot = $pgPath.split('"')[1].replace("\bin\pg_ctl.exe", "")
    $env:Path += ";${env:PGBIN}"
    $pgVersion = (postgres --version).split()[2].Trim()
    $content = [PSCustomObject]@{
        Version = $pgVersion
        UserName = $env:PGUSER
        Password = $env:PGPASSWORD
        EnvironmentVariables = "PGBIN=$env:PGBIN; <br> PGDATA=$env:PGDATA; <br> PGROOT=$env:PGROOT"
        Path = $pgRoot
        ServiceName = $pgService.Name
        ServiceStatus = $pgService.State
        ServiceStartType = $pgService.StartMode
    } | New-MDTable

    Build-MarkdownElement -Head $name -Content $content
}

function Get-MongoDBMarkdown
{
    $name = "MongoDB"
    $mongoService = Get-Service -Name $name
    $mongoVersion = (Get-Command -Name 'mongo').Version.ToString()
    $content = [PSCustomObject]@{
        Version = $mongoVersion
        ServiceName = $name
        ServiceStatus = $mongoService.Status
        ServiceStartType = $mongoService.StartType
    } | New-MDTable
    Build-MarkdownElement -Head $name -Content $content
}

function Build-DatabasesMarkdown
{
    $markdown = ""
    $markdown += Get-PostgreSQLMarkdown
    $markdown += Get-MongoDBMarkdown
    $markdown
}
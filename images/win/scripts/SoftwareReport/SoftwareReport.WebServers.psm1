function Get-ApachePath {
    return Join-Path "C:\tools\" (Get-Item C:\tools\apache*).Name
}

function Get-NginxPath {
    return Join-Path "C:\tools\" (Get-Item C:\tools\nginx*).Name
}

function Get-ApacheVersion {
    $apacheBinPath = Join-Path (Get-ApachePath) "\bin\httpd"
    (. $apacheBinPath -V | Select-String -Pattern "Apache/") -match "Apache/(?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.Version
}

function Get-NginxVersion {
    $nginxBinPath = Join-Path (Get-NginxPath) "nginx"
    (cmd /c "$nginxBinPath -v 2>&1") -match "nginx/(?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.Version
}

function Get-ApacheMarkdown
{
    $name = "Apache"
    $apachePort = "80"
    $apacheService = Get-Service -Name $name
    $apacheVersion = Get-ApacheVersion
    $apacheConfigFile = Join-Path (Get-ApachePath) "\conf\httpd.conf"
    return [PSCustomObject]@{
        Name = $name
        Version = $apacheVersion
        ConfigFile = $apacheConfigFile
        ServiceName = $apacheService.Name
        ServiceStatus = $apacheService.Status
        ListenPort = $apachePort
    }
}

function Get-NginxMarkdown
{
    $name = "Nginx"
    $nginxPort = "80"
    $nginxService = Get-Service -Name $name
    $nginxVersion = Get-NginxVersion
    $nginxConfigFile = Join-Path (Get-NginxPath) "\conf\nginx.conf"
    return [PSCustomObject]@{
        Name = $name
        Version = $nginxVersion
        ConfigFile = $nginxConfigFile
        ServiceName = $nginxService.Name
        ServiceStatus = $nginxService.Status
        ListenPort = $nginxPort
    }
}

function Build-WebServersSection {
    $output = ""
    $output += New-MDHeader "Web Servers" -Level 3
    $output += @(
    (Get-ApacheMarkdown),
    (Get-NginxMarkdown)
    ) | Sort-Object Name | New-MDTable

    $output += New-MDNewLine
    return $output
}
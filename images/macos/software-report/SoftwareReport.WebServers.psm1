using module ./../helpers/SoftwareReport.Helpers.psm1

function Get-ApacheVersion {
    $name = "httpd"
    $port = 80
    $version = brew list $name --versions | Take-Part -Part 1
    $serviceStatus = (brew services list) -match $name | Take-Part -Part 1
    $configFile = "$(brew --prefix)/etc/httpd/httpd.conf"
    return [PsCustomObject]@{
        "Name" = $name
        "Version" = $version
        "ConfigFile" = $configFile
        "ServiceStatus" = $serviceStatus
        "ListenPort" = $port
    }
}

function Get-NginxVersion {
    $name = "nginx"
    $port = 80
    $version = brew list $name --versions | Take-Part -Part 1
    $serviceStatus = (brew services list) -match $name | Take-Part -Part 1
    $configFile = "$(brew --prefix)/etc/nginx/nginx.conf"
    return [PsCustomObject]@{
        "Name" = $name
        "Version" = $version
        "ConfigFile" = $configFile
        "ServiceStatus" = $serviceStatus
        "ListenPort" = $port
    }
}

function Build-WebServersSection {
    param (
        [ArchiveItems] $Archive
    )

    $output = ""
    $output += New-MDHeader $archive.SetHeader("Web Servers", 3) -Level 3
    $servers += @(
        (Get-ApacheVersion),
        (Get-NginxVersion)
    )
    $output += $servers | Sort-Object Name | New-MDTable
    $output += New-MDNewLine

    $servers | ForEach-Object { $Archive.Add("$($_.Name)|$($_.Version)|$($_.ConfigFile)|$($_.ServiceStatus)|$($_.ListenPort)", "WebServers_$($_.Name)") } | Out-Null

    return $output
}

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
    return @(
        (Get-ApacheVersion),
        (Get-NginxVersion)
    )
}

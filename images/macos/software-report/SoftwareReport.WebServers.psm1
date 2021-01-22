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
    $output = ""
    $output += New-MDHeader "Web Servers" -Level 3
    $output += @(
        (Get-ApacheVersion),
        (Get-NginxVersion)
    ) | Sort-Object Name | New-MDTable
    
    $output += New-MDHeader "Notes:" -Level 5
    $output += @'
```
    1. Start the service formula immediately
    brew services start $service
    2. List all managed services
    brew services list | grep $service
    3. Port 80 availability check
    sudo lsof -i :80 | grep LISTEN
    4. Stop the service formula immediately
    brew services stop "$service"
```
'@
    return $output
}

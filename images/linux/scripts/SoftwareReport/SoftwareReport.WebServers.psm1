function Get-ApacheVersion {
    $name = "apache2"
    $port = 80
    $version = bash -c "apache2 -v | grep -Po 'Apache/(\d+.){2}\d+'" | Take-OutputPart -Part 1 -Delimiter "/"
    $serviceStatus = systemctl status apache2 | grep "Active:" | Take-OutputPart -Part 1
    $configFile = "/etc/apache2/apache2.conf"
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
    $version = (dpkg-query --showformat='${Version}' --show nginx).Split('-')[0]
    $serviceStatus = systemctl status nginx | grep "Active:" | Take-OutputPart -Part 1
    $configFile = "/etc/nginx/nginx.conf"
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

    $output += New-MDNewLine
    return $output
}
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

function Get-Xsp4Version {
    $name = "mono-xsp4"
    $port = (grep '^port=' /etc/default/mono-xsp4).Split('=')[1]
    $version = (dpkg-query --showformat='${Version}' --show mono-xsp4).Split('-')[0]
    $serviceStatus = systemctl show -p ActiveState --value mono-xsp4
    $configFile = "/etc/default/mono-xsp4"
    return [PsCustomObject]@{
        "Name" = $name
        "Version" = $version
        "ConfigFile" = $configFile
        "ServiceStatus" = $serviceStatus
        "ListenPort" = $port
    }
}

function Build-WebServersSection {
    $servers = @(
        (Get-ApacheVersion),
        (Get-NginxVersion)
    )
    if (Test-IsUbuntu20) {
        $servers += (Get-Xsp4Version)
    }

    $output = ""
    $output += New-MDHeader "Web Servers" -Level 3
    $output += $servers | Sort-Object Name | New-MDTable
    $output += New-MDNewLine

    return $output
}

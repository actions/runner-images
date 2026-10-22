function Get-BashVersion {
    $version = bash -c 'echo ${BASH_VERSION}'
    return $version
}

function Get-DashVersion {
    $version = dpkg-query -W -f '${Version}' dash
    return $version
}

function Get-NodeVersion {
    $nodeVersion = $(node --version).Substring(1)
    return $nodeVersion
}

function Get-OpensslVersion {
    $opensslVersion = $(dpkg-query -W -f '${Version}' openssl)
    return $opensslVersion
}

function Get-PerlVersion {
    $version = $(perl -e 'print substr($^V,1)')
    return $version
}

function Get-PythonVersion {
    $result = Get-CommandResult "python --version"
    $version = $result.Output | Get-StringPart -Part 1
    return $version
}

function Get-PowershellVersion {
    $pwshVersion = $(pwsh --version) | Get-StringPart -Part 1
    return $pwshVersion
}

function Get-NpmVersion {
    $npmVersion = npm --version
    return $npmVersion
}

function Get-PipVersion {
    $pipVersion = pip --version | Get-StringPart -Part 1
    return $pipVersion
}

function Get-Pip3Version {
    $pip3Version = pip3 --version | Get-StringPart -Part 1
    return $pip3Version
}

function Get-AptPackages {
    $apt = (Get-ToolsetContent).Apt
    $output = @()
    ForEach ($pkg in ($apt.vital_packages + $apt.common_packages + $apt.cmd_packages)) {
        $version = $(dpkg-query -W -f '${Version}' $pkg)
        if ($null -eq $version) {
            $version = $(dpkg-query -W -f '${Version}' "$pkg*")
        }

        $version = $version -replace '~','\~'

        $output += [PSCustomObject] @{
            Name    = $pkg
            Version = $version
        }
    }
    return ($output | Sort-Object Name)
}

function Get-PipxVersion {
    $result = (Get-CommandResult "pipx --version").Output
    $result -match "(?<version>\d+\.\d+\.\d+\.?\d*)" | Out-Null
    return $Matches.Version
}

function Get-SystemdVersion {
    $matchCollection = [regex]::Matches((systemctl --version | head -n 1), "\((.*?)\)")
    $result = foreach ($match in $matchCollection) {$match.Groups[1].Value}
    return $result
}

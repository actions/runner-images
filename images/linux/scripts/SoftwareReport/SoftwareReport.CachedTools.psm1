function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "PyPy"
    Get-ChildItem -Path $toolcachePath -Name | Sort-Object { [Version] $_ } | ForEach-Object {
        $pypyRootPath = Join-Path $toolcachePath $_ "x64"
        [string]$pypyVersionOutput = & "$pypyRootPath/bin/python" -c "import sys;print(sys.version)"
        $pypyVersionOutput -match "^([\d\.]+) \(.+\) \[PyPy ([\d\.]+) .+]$" | Out-Null
        return "{0} [PyPy {1}]" -f $Matches[1], $Matches[2]
    }
}

function Get-ToolcacheNodeVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "node"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheGoVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "go"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Build-GoEnvironmentTable {
    return Get-CachedToolInstances -Name "go" -VersionCommand "version" | ForEach-Object {
        $Version = [System.Version]($_.Version -Split(" "))[0]
        $Name = "GOROOT_$($Version.major)_$($Version.minor)_X64"
        $Value = (Get-Item env:\$Name).Value
        [PSCustomObject] @{
            "Name" = $Name
            "Value" = (Get-Item env:\$Name).Value
            "Architecture" = $_. Architecture
        }
    }
}

function Get-ToolcacheBoostVersions {
    $Name = "Boost"
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "boost"
    if (-not (Test-Path $toolcachePath)) {
        return @()
    }

    $BoostVersions = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    $ToolInstances = $BoostVersions | ForEach-Object {
        $VersionEnvVar = $_.replace(".", "_")
        return @{
            Version = $_
            Architecture = "x64"
            "Environment Variable" = "BOOST_ROOT_${VersionEnvVar}"

        }
    }
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        Version = "left";
        Architecture = "left";
        "Environment Variable" = "left"
    })

    $markdown = ""

    if ($Content.Count -gt 0) {
        $markdown += New-MDHeader $Name -Level 4
        $markdown += New-MDParagraph -Lines $Content
    }

    return $markdown
}

function Build-CachedToolsSection {
    $output = ""

    $output += Get-ToolcacheBoostVersions

    $output += New-MDHeader "Go" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheGoVersions) -Style Unordered

    $output += New-MDHeader "Node.js" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheNodeVersions) -Style Unordered

    $output += New-MDHeader "PyPy" -Level 4
    $output += New-MDList -Lines (Get-ToolcachePyPyVersions) -Style Unordered

    $output += New-MDHeader "Python" -Level 4
    $output += New-MDList -Lines (Get-ToolcachePythonVersions) -Style Unordered

    $output += New-MDHeader "Ruby" -Level 4
    $output += New-MDList -Lines (Get-ToolcacheRubyVersions) -Style Unordered

    return $output
}

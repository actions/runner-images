Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Get-ToolcacheRubyVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Ruby"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    $output | ForEach-Object {
        $id = $_
        if ($id -match '^\d{1,2}\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add($_, "Ruby_$id") | Out-Null
    }

    return $output
}

function Get-ToolcachePythonVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Python"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    $output | ForEach-Object {
        $id = $_
        if ($id -match '^\d{1,2}\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add($_, "Python_$id") | Out-Null
    }

    return $output
}

function Get-ToolcachePyPyVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:HOME "hostedtoolcache/PyPy/*/x64"
    $output = Get-ChildItem -Path $toolcachePath | Sort-Object { [Version] $_.Parent.Name } | ForEach-Object {
        $foundVersionPath = $_.FullName
        $foundVersionName = (Get-Item ($foundVersionPath -replace "x64") | Sort-Object -Property {[version]$_.name} -Descending | Select-Object -First 1).name
        $arrPyPyVersion = ((& "$foundVersionPath/bin/python" -c "import sys;print(sys.version.split('\n')[1])") -split " ")
        $pypyVersion = "$($arrPyPyVersion[0]) $($arrPyPyVersion[1])"
        return "{0} {1}]" -f $foundVersionName, $pypyVersion
    }
    $output | ForEach-Object {
        $id = $_
        if ($id -match '^\d{1,2}\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add($_, "PyPy_$id") | Out-Null
    }

    return $output
}

function Get-ToolcacheNodeVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Node"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    $output | ForEach-Object {
        $id = $_
        if ($id -match '^\d{1,2}\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add($_, "NodeJs_$id") | Out-Null
    }

    return $output
}

function Get-ToolcacheGoTable {
    param (
        [ArchiveItems] $Archive
    )

    $ToolInstances = Get-CachedToolInstances -Name "Go" -VersionCommand "version"
    foreach ($Instance in $ToolInstances) {
        $Version = [System.Version]($Instance.Version -Split(" "))[0]
        $Instance."Environment Variable" = "GOROOT_$($Version.major)_$($Version.minor)_X64"
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        Version = "left";
        Architecture = "left";
        "Environment Variable" = "left"
    })

    $ToolInstances | ForEach-Object { $Archive.Add("$($_.Version)|$($_.Architecture)|$($_."Environment Variable")", "Go_$($_."Environment Variable")") } | Out-Null

    return $Content
}

function Build-ToolcacheSection { 
    param (
        [ArchiveItems] $Archive
    )

    $output = ""
    $output += New-MDHeader $Archive.SetHeader("Cached Tools", 3) -Level 3
    $output += New-MDHeader $Archive.SetHeader("Ruby", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcacheRubyVersions $Archive) -Style Unordered
    $output += New-MDHeader $Archive.SetHeader("Python", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcachePythonVersions $Archive) -Style Unordered
    $output += New-MDHeader $Archive.SetHeader("PyPy", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcachePyPyVersions $Archive) -Style Unordered
    $output += New-MDHeader $Archive.SetHeader("Node.js", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcacheNodeVersions $Archive) -Style Unordered
    $output += New-MDHeader $Archive.SetHeader("Go", 4) -Level 4
    $output += Get-ToolcacheGoTable $Archive

    return $output
}

function Get-PowerShellModules {
    param (
        [ArchiveItems] $Archive
    )

    $modules = (Get-ToolsetValue powershellModules).name

    $psModules = Get-Module -Name $modules -ListAvailable | Sort-Object Name | Group-Object Name
    $output = $psModules | ForEach-Object {
        $moduleName = $_.Name
        $moduleVersions = ($_.group.Version | Sort-Object -Unique) -join '<br>'

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
        }
    }

    $output | ForEach-Object { $Archive.Add("$($_.Module)|$($_.Version)", "PowerShellModules_$($_.Module)") } | Out-Null

    return $output
}
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache/PyPy/*/x64"
    Get-ChildItem -Path $toolcachePath | Sort-Object { [Version] $_.Parent.Name } | ForEach-Object {
        $foundVersionPath = $_.FullName
        $foundVersionName = (Get-Item ($foundVersionPath -replace "x64") | Sort-Object -Property {[version]$_.name} -Descending | Select-Object -First 1).name
        $arrPyPyVersion = ((& "$foundVersionPath/bin/python" -c "import sys;print(sys.version.split('\n')[1])") -split " ")
        $pypyVersion = "$($arrPyPyVersion[0]) $($arrPyPyVersion[1])"
        return "{0} {1}]" -f $foundVersionName, $pypyVersion
    }
}

function Get-ToolcacheNodeVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Node"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheGoTable {
    $ToolInstances = Get-CachedToolInstances -Name "Go" -VersionCommand "version"
    foreach ($Instance in $ToolInstances) {
        $Version = [System.Version]($Instance.Version -Split(" "))[0]
        $Instance."Environment Variable" = "GOROOT_$($Version.major)_$($Version.minor)_X64"
    }

    $Content = $ToolInstances | ForEach-Object {
        return [PSCustomObject]@{
            Version = $_.Version
            Architecture = $_.Architecture
            "Environment Variable" = $_."Environment Variable"
        }
    }

    return $Content
}

function Build-ToolcacheSection { 
    $goToolNode = [HeaderNode]::new("Go")
    $goToolNode.AddTableNode($(Get-ToolcacheGoTable))
    return @(
        [ToolVersionsNode]::new("Ruby", $(Get-ToolcacheRubyVersions))
        [ToolVersionsNode]::new("Python", $(Get-ToolcachePythonVersions))
        [ToolVersionsNode]::new("Pypy", $(Get-ToolcachePyPyVersions))
        [ToolVersionsNode]::new("Node.js", $(Get-ToolcacheNodeVersions))
        $goToolNode
    )
}

function Get-PowerShellModules {
    $modules = (Get-ToolsetValue powershellModules).name

    $psModules = Get-Module -Name $modules -ListAvailable | Sort-Object Name | Group-Object Name
    return $psModules | ForEach-Object {
        $moduleName = $_.Name
        $moduleVersions = ($_.group.Version | Sort-Object -Unique) -join '<br>'

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
        }
    }
}
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

function Get-ToolcacheGoVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Go"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Build-ToolcacheSection { 
    return @(
        [ToolVersionsListNode]::new("Ruby", $(Get-ToolcacheRubyVersions), '^\d+\.\d+', "List"),
        [ToolVersionsListNode]::new("Python", $(Get-ToolcachePythonVersions), '^\d+\.\d+', "List"), 
        [ToolVersionsListNode]::new("PyPy", $(Get-ToolcachePyPyVersions), '^\d+\.\d+', "List"),
        [ToolVersionsListNode]::new("Node.js", $(Get-ToolcacheNodeVersions), '^\d+', "List"),
        [ToolVersionsListNode]::new("Go", $(Get-ToolcacheGoVersions), '^\d+\.\d+', "List")
    )
}

function Get-PowerShellModules {
    $modules = (Get-ToolsetValue powershellModules).name
    $modules | ForEach-Object {
        $moduleName = $_
        $moduleVersions = Get-Module -Name $moduleName -ListAvailable | Select-Object -ExpandProperty Version | Sort-Object -Unique
        return [ToolVersionsListNode]::new($moduleName, $moduleVersions, '^\d+', "Inline")
    }
}
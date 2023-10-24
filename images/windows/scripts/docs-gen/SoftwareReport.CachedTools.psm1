function Get-ToolcacheGoVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Go"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheNodeVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Node"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "PyPy"
    Get-ChildItem -Path $toolcachePath -Name | Sort-Object { [Version] $_ } | ForEach-Object {
        $pypyRootPath = Join-Path $toolcachePath $_ "x86"
        [string]$pypyVersionOutput = & "$pypyRootPath\python.exe" -c "import sys;print(sys.version)"
        $pypyVersionOutput -match "^([\d\.]+) \(.+\) \[PyPy ([\d\.]+\S*) .+]$" | Out-Null
        return "{0} [PyPy {1}]" -f $Matches[1], $Matches[2]
    }
}

function Build-CachedToolsSection
{
    return @(
        [ToolVersionsListNode]::new("Go", $(Get-ToolcacheGoVersions), '^\d+\.\d+', 'List'),
        [ToolVersionsListNode]::new("Node.js", $(Get-ToolcacheNodeVersions), '^\d+', 'List'),
        [ToolVersionsListNode]::new("Python", $(Get-ToolcachePythonVersions), '^\d+\.\d+', 'List'), 
        [ToolVersionsListNode]::new("PyPy", $(Get-ToolcachePyPyVersions), '^\d+\.\d+', 'List'),
        [ToolVersionsListNode]::new("Ruby", $(Get-ToolcacheRubyVersions), '^\d+\.\d+', 'List')
    )
}

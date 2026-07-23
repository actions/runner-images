function Get-ToolcacheVersions {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ToolName
    )

    # The set of cached tools differs between images and architectures,
    # so a missing folder means the tool is not cached rather than an error.
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY $ToolName
    if (-not (Test-Path $toolcachePath)) {
        return @()
    }

    return @(Get-ChildItem $toolcachePath -Name | Sort-Object { [Version] $_ })
}

function Get-ToolcacheRubyVersions {
    return Get-ToolcacheVersions -ToolName "Ruby"
}

function Get-ToolcachePythonVersions {
    return Get-ToolcacheVersions -ToolName "Python"
}

function Get-ToolcachePyPyVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "PyPy"
    Get-ToolcacheVersions -ToolName "PyPy" | ForEach-Object {
        $pypyRootPath = Join-Path $toolcachePath $_ "x64"
        [string] $pypyVersionOutput = & "$pypyRootPath/bin/python" -c "import sys;print(sys.version)"
        $pypyVersionOutput -match "^([\d\.]+) \(.+\) \[PyPy ([\d\.]+\S*) .+]$" | Out-Null
        return "{0} [PyPy {1}]" -f $Matches[1], $Matches[2]
    }
}

function Get-ToolcacheNodeVersions {
    return Get-ToolcacheVersions -ToolName "node"
}

function Get-ToolcacheGoVersions {
    return Get-ToolcacheVersions -ToolName "go"
}

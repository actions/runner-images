Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

function Get-ToolcacheRubyVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Ruby"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
}

function Get-ToolcachePythonVersions {
    $toolcachePath = Join-Path $env:HOME "hostedtoolcache" "Python"
    return Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
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

    $nodes = @()
    $nodes += @(
        [ToolVersionsListNode]::new("Ruby", $(Get-ToolcacheRubyVersions), '^\d+\.\d+', "List")
        [ToolVersionsListNode]::new("Python", $(Get-ToolcachePythonVersions), '^\d+\.\d+', "List"),
        [ToolVersionsListNode]::new("Node.js", $(Get-ToolcacheNodeVersions), '^\d+', "List"),
        [ToolVersionsListNode]::new("Go", $(Get-ToolcacheGoVersions), '^\d+\.\d+', "List")
    )

    return $nodes
}

function Get-PowerShellModules {
    $modules = ((Get-ToolsetContent).powershellModules).name
    $modules | ForEach-Object {
        $moduleName = $_
        $moduleVersions = Get-Module -Name $moduleName -ListAvailable | Select-Object -ExpandProperty Version | Sort-Object -Unique
        return [ToolVersionsListNode]::new($moduleName, $moduleVersions, '^\d+', "Inline")
    }
}

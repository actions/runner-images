function Get-ToolcacheRubyVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Ruby"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    Add-ToolListToArchive $output "Ruby" $Archive
    
    return $output
}

function Get-ToolcachePythonVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Python"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    Add-ToolListToArchive $output "Python" $Archive
    
    return $output
}

function Get-ToolcachePyPyVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "PyPy"
    $output = Get-ChildItem -Path $toolcachePath -Name | Sort-Object { [Version] $_ } | ForEach-Object {
        $pypyRootPath = Join-Path $toolcachePath $_ "x64"
        [string]$pypyVersionOutput = & "$pypyRootPath/bin/python" -c "import sys;print(sys.version)"
        $pypyVersionOutput -match "^([\d\.]+) \(.+\) \[PyPy ([\d\.]+\S*) .+]$" | Out-Null
        return "{0} [PyPy {1}]" -f $Matches[1], $Matches[2]
    }
    Add-ToolListToArchive $output "PyPy" $Archive

    return $output
}

function Get-ToolcacheNodeVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "node"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    Add-ToolListToArchive $output "NodeJs" $Archive
    
    return $output
}

function Get-ToolcacheGoVersions {
    param (
        [ArchiveItems] $Archive
    )

    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "go"
    $output = Get-ChildItem $toolcachePath -Name | Sort-Object { [Version]$_ }
    Add-ToolListToArchive $output "Go" $Archive

    return $output
}

function Add-ToolListToArchive {
    param (
        [object] $ToolItems,
        [string] $ArchiveId,
        [ArchiveItems] $Archive
    )

    $ToolItems | ForEach-Object {
        $idSuffix = $_
        if ($_ -match '^\d{1,2}\.\d{1,2}\.') {
            $idSuffix = $matches[0]
        }
        $Archive.Add($_, "$($ArchiveId)_$($idSuffix)") | Out-Null
    }
}

function Build-GoEnvironmentTable {
    param (
        [ArchiveItems] $Archive
    )

    $output = Get-CachedToolInstances -Name "go" -VersionCommand "version" | ForEach-Object {
        $Version = [System.Version]($_.Version -Split(" "))[0]
        $Name = "GOROOT_$($Version.major)_$($Version.minor)_X64"
        $Value = (Get-Item env:\$Name).Value
        [PSCustomObject] @{
            "Name" = $Name
            "Value" = (Get-Item env:\$Name).Value
            "Architecture" = $_. Architecture
        }
    }

    $output | ForEach-Object { $Archive.Add("$($_.Name)|$($_.Value)|$($_.Architecture)", "Env_$($_.Name)") } | Out-Null

    return $output
}

function Build-CachedToolsSection {
    param (
        [ArchiveItems] $Archive
    )

    $output = ""

    $output += New-MDHeader $Archive.SetHeader("Go", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcacheGoVersions $Archive) -Style Unordered

    $output += New-MDHeader $Archive.SetHeader("Node.js", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcacheNodeVersions $Archive) -Style Unordered

    $output += New-MDHeader $Archive.SetHeader("PyPy", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcachePyPyVersions $Archive) -Style Unordered

    $output += New-MDHeader $Archive.SetHeader("Python", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcachePythonVersions $Archive) -Style Unordered

    $output += New-MDHeader $Archive.SetHeader("Ruby", 4) -Level 4
    $output += New-MDList -Lines (Get-ToolcacheRubyVersions $Archive) -Style Unordered

    return $output
}

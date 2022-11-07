using module ./SoftwareReport.Helpers.psm1

function Get-GoMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $Name = "Go"
    $Archive.SetHeader($Name, 4) | Out-Null
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "version"
    foreach ($Instance in $ToolInstances)
    {
        $Version = [System.Version]($Instance.Version -Split(" "))[0]
        $Instance."Environment Variable" = "GOROOT_$($Version.major)_$($Version.minor)_X64"

        $Archive.Add("$($Instance.Version)|$($Instance.Architecture)|$($Instance."Environment Variable")", "Go_$($Instance."Environment Variable")") | Out-Null
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        Version = "left";
        Architecture = "left";
        "Environment Variable" = "left"
    })

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-NodeMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $Name = "Node"
    $Archive.SetHeader($Name, 4) | Out-Null
    $ToolInstances = Get-CachedToolInstances -Name $Name
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    foreach ($instance in $ToolInstances) {
        $id = $instance.Version
        if ($instance.Version -match '^\d{1,2}\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add("$($instance.Version)|$($instance.Architecture)", "Node_$id") | Out-Null
    }

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PythonMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $Name = "Python"
    $Archive.SetHeader($Name, 4) | Out-Null
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    foreach ($instance in $ToolInstances) {
        $id = $instance.Version
        if ($instance.Version -match '^\d\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add("$($instance.Version)|$($instance.Architecture)", "Python_$id") | Out-Null
    }

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-RubyMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $Name = "Ruby"
    $Archive.SetHeader($Name, 4) | Out-Null
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    foreach ($instance in $ToolInstances) {
        $id = $instance.Version
        if ($instance.Version -match '^\d\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add("$($instance.Version)|$($instance.Architecture)", "Ruby_$id") | Out-Null
    }

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PyPyMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $Name = "PyPy"
    $Archive.SetHeader($Name, 4) | Out-Null
    $ToolInstances = Get-CachedToolInstances -Name $Name
    foreach ($Instance in $ToolInstances)
    {
        $Instance."PyPy Version" = @()
        $Instance."Python Version" = $Instance.Version
        foreach ($Arch in $Instance.Architecture_Array)
        {
            $pythonExePath = Join-Path $Instance.Path $Arch | Join-Path -ChildPath "python.exe"
            $Instance."PyPy Version" += (& $pythonExePath -c "import sys;print(sys.version.split('\n')[1])").Trim("[]")
        }

        $id = $instance.Version
        if ($instance.Version -match '^\d\.\d{1,2}\.') {
            $id = $matches[0]
        }
        $Archive.Add("$($instance."Python Version")|$($instance."PyPy Version")", "PyPy_$id") | Out-Null
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        "Python Version" = "left";
        "PyPy Version" = "left"
    })

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Build-CachedToolsMarkdown
{
    param (
        [ArchiveItems] $Archive
    )

    $markdown = ""
    $markdown += Get-GoMarkdown $Archive
    $markdown += Get-NodeMarkdown $Archive
    $markdown += Get-PythonMarkdown $Archive
    $markdown += Get-RubyMarkdown $Archive
    $markdown += Get-PyPyMarkdown $Archive

    return $markdown
}

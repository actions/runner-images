function Get-GoMarkdown
{
    $Name = "Go"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "version"
    foreach ($Instance in $ToolInstances)
    {
        $Version = [System.Version]($Instance.Version -Split(" "))[0]
        $Instance."Environment Variable" = "GOROOT_$($Version.major)_$($Version.minor)_X64"
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
    $Name = "Node"
    $ToolInstances = Get-CachedToolInstances -Name $Name
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PythonMarkdown
{
    $Name = "Python"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-RubyMarkdown
{
    $Name = "Ruby"
    $ToolInstances = Get-CachedToolInstances -Name $Name -VersionCommand "--version"
    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{Version = "left"; Architecture = "left"})

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Get-PyPyMarkdown
{
    $Name = "PyPy"
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
    }

    $Content = $ToolInstances | New-MDTable -Columns ([ordered]@{
        "Python Version" = "left";
        "PyPy Version" = "left"
    })

    return Build-MarkdownElement -Head $Name -Content $Content
}

function Build-CachedToolsMarkdown
{
    $markdown = ""
    $markdown += Get-GoMarkdown
    $markdown += Get-NodeMarkdown
    $markdown += Get-PythonMarkdown
    $markdown += Get-RubyMarkdown
    $markdown += Get-PyPyMarkdown

    return $markdown
}

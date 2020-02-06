################################################################################
##  File:  Validate-ToolCache.ps1
##  Desc:  Validate Tool Cache
################################################################################

# Helpers
function GetChildFolders {
    param (
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    return Get-ChildItem -Path $Path -Directory -Name
}

function Get-ToolcachePackages {
    $toolcachePath = Join-Path $env:ROOT_FOLDER "toolcache.json"
    return Get-Content -Raw $toolcachePath | ConvertFrom-Json
}

$toolcachePackages = (Get-ToolcachePackages).PSObject.Properties | ForEach-Object {
    $packageNameParts = $_.Name.Split("-")
    return [PSCustomObject] @{
        ToolName = $packageNameParts[1]
        Versions = $_.Value
        Architecture = $packageNameParts[3]
    }
}

function GetToolsByName {
    param (
        [Parameter(Mandatory = $True)]
        [string]$SoftwareName
    )
    return $toolcachePackages | Where-Object { $_.ToolName -eq $SoftwareName }
}

function RunTestsByPath {
    param (
        [Parameter(Mandatory = $True)]
        [string[]]$ExecTests,
        [Parameter(Mandatory = $True)]
        [string]$Path,
        [Parameter(Mandatory = $True)]
        [string]$SoftwareName,
        [Parameter(Mandatory = $True)]
        [string]$SoftwareVersion,
        [Parameter(Mandatory = $True)]
        [string]$SoftwareArchitecture
    )

    foreach ($test in $ExecTests)
    {
        if (Test-Path "$Path\$test")
        {
            Write-Host "$SoftwareName($test) $SoftwareVersion($SoftwareArchitecture) is successfully installed:"
            Write-Host (& "$Path\$test" --version)
        }
        else
        {
            Write-Host "$SoftwareName($test) $SoftwareVersion($SoftwareArchitecture) is not installed"
            exit 1
        }
    }
}

function GetMarkdownDescription {
    param (
        [Parameter(Mandatory = $True)]
        [string]$SoftwareVersion,
        [Parameter(Mandatory = $True)]
        [string]$SoftwareArchitecture
    )
    return "_Version:_ $SoftwareVersion ($SoftwareArchitecture)<br/>"
}

function ToolcacheTest {
    param (
        [Parameter(Mandatory = $True)]
        [string]$SoftwareName,
        [Parameter(Mandatory = $True)]
        [string[]]$ExecTests
    )

    $softwarePath = "$env:AGENT_TOOLSDIRECTORY\$SoftwareName"

    if (-Not (Test-Path $softwarePath))
    {
        Write-Host "$softwarePath does not exist"
        exit 1
    }

    [array]$installedVersions = GetChildFolders -Path $softwarePath
    if ($installedVersions.count -eq 0)
    {
        Write-Host "$softwarePath does not include any folders"
        exit 1
    }

    $markdownDescription = ""
    $tools = GetToolsByName -SoftwareName $SoftwareName
    foreach($tool in $tools)
    {
        foreach ($version in $tool.Versions)
        {
            $foundVersion = $installedVersions | where { $_.StartsWith($version) }
            if ($foundVersion -eq $null)
            {
                Write-Host "$softwarePath\$version.* was not found"
                exit 1
            }

            $installedArchitecture = GetChildFolders -Path "$softwarePath\$foundVersion"
            $requiredArchitecture = $tool.Architecture
            if (-Not ($installedArchitecture -Contains $requiredArchitecture))
            {
                Write-Host "$softwarePath\$foundVersion does not include the $requiredArchitecture architecture"
                exit 1
            }

            $path = "$softwarePath\$foundVersion\$requiredArchitecture"
            RunTestsByPath -ExecTests $ExecTests -Path $path -SoftwareName $SoftwareName -SoftwareVersion $foundVersion -SoftwareArchitecture $requiredArchitecture

            $markdownDescription += GetMarkdownDescription -SoftwareVersion $foundVersion -SoftwareArchitecture $requiredArchitecture
        }
    }
    Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $markdownDescription
}

# Python test
$PythonTests = @("python.exe", "Scripts\pip.exe")
ToolcacheTest -SoftwareName "Python" -ExecTests $PythonTests

# PyPy test
$PyPyTests = @("python.exe", "bin\pip.exe")
ToolcacheTest -SoftwareName "PyPy" -ExecTests $PyPyTests

# Ruby test
$RubyTests = @("bin\ruby.exe")
ToolcacheTest -SoftwareName "Ruby" -ExecTests $RubyTests

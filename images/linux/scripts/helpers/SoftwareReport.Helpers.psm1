function Take-OutputPart {
    param (
        [Parameter(ValueFromPipeline)]
        [string] $toolOutput,
        [string] $Delimiter = " ",
        [int[]] $Part
    )
    $parts = $toolOutput.Split($Delimiter, [System.StringSplitOptions]::RemoveEmptyEntries)
    $selectedParts = $parts[$Part]
    return [string]::Join($Delimiter, $selectedParts)
}

function New-MDNewLine {
    param (
        [int] $Count = 1
    )
    $newLineSymbol = [System.Environment]::NewLine
    return $newLineSymbol * $Count
}

function Restore-UserOwner {
    sudo chown -R ${env:USER}: $env:HOME
}

function Get-LinkTarget {
    param (
        [string] $inputPath
    )
    $link = Get-Item $inputPath | Select-Object -ExpandProperty Target
    if ($link) {
      return " -> $link"
    }
    return ""
}

function Get-PathWithLink {
    param (
        [string] $inputPath
    )
    $link = Get-LinkTarget($inputPath)
    return "${inputPath}${link}"
}

function Get-CachedToolInstances
{
    <#
    .SYNOPSIS
    Returns hastable of installed cached tools.

    .DESCRIPTION
    Return hastable that contains versions and architectures for selected cached tool.

    .PARAMETER Name
    Name of cached tool.

    .PARAMETER VersionCommand
    Optional parameter. Command to return version of system default tool.

    .EXAMPLE
    Get-CachedToolInstances -Name "Python" -VersionCommand "--version"

    #>

    param
    (
        [String] $Name,
        [String] $VersionCommand
    )

    $toolInstances = @()
    $toolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $Name

    # Get all installed versions from TOOLSDIRECTORY folder
    $versions = Get-ChildItem $toolPath | Sort-Object { [System.Version]$_.Name }
    foreach ($version in $versions)
    {
        $instanceInfo = @{}

        # Create instance hashtable
        [string]$instanceInfo.Path = Join-Path -Path $toolPath -ChildPath $version.Name
        [string]$instanceInfo.Version = $version.Name

        # Get all architectures for current version
        [array]$instanceInfo.Architecture_Array = Get-ChildItem $version.FullName -Name -Directory | Where-Object { $_ -match "^x[0-9]{2}$" }
        [string]$instanceInfo.Architecture = $instanceInfo.Architecture_Array -Join ", "

        # Add (default) postfix to version name, in case if current version is in environment path
        if (-not ([string]::IsNullOrEmpty($VersionCommand)))
        {
            $defaultVersion = $(& ($Name.ToLower()) $VersionCommand 2>&1)
            $defaultToolVersion = $defaultVersion   | Select-String -Pattern "\d+\.\d+\.\d+" -AllMatches `
                                                    | ForEach-Object { $_.Matches.Value }

            if ([version]$version.Name -eq [version]$defaultToolVersion)
            {
                $instanceInfo.Version += " (Default)"
            }
        }

        $toolInstances += $instanceInfo
    }

    return $toolInstances
}

function Get-AptSourceRepository {
    param([String] $PackageName)

    $sourceUrl = Get-Content "$PSScriptRoot/../helpers/apt-sources.txt" | Select-String -Pattern $PackageName | Take-OutputPart -Part (1..3)
    return $sourceUrl
}


class ArchiveItem {
    [string] $Id
    [string] $Title
    [string[]] $Headers
}

class ArchiveItems {
    hidden [System.Collections.ArrayList] $items
    hidden [string[]] $activeHeaders

    ArchiveItems() {
        $this.items = New-Object System.Collections.ArrayList
        $this.activeHeaders = New-Object string[] 5
    }

    [string] Add($Title, $Id) {
        $item = [ArchiveItem]::New()
        $item.Id = $Id
        $item.Title = $Title
        $item.Headers = $this.activeHeaders | ForEach-Object { $_ } | Where-Object { $_.Length -ge 1 }
        $this.items.Add($item) | Out-Null

        return $Title
    }

    [string] Add($TitleIdPair) {
        return $this.Add($TitleIdPair[0], $TitleIdPair[1])
    }

    [string] SetHeader($Name, $Level) {
        if ($Level -lt 1 -or $Level -gt $this.activeHeaders.Length) {
            Write-Warning"[!] [ArchiveItems] Header level must be 1..5"
            return $Name
        }

        $this.activeHeaders[$Level-1] = $Name
        for ($i = $Level; $i -lt $this.activeHeaders.Length; $i++) {
            $this.activeHeaders[$i] = ""
        }
        return $Name
    }

    [string] ToJson() {
        $final = @()
        foreach ($item in $this.items) {
            $headersLevel = $item.Headers.Count
            $headers = $headersLevel -ge 4 ? @($item.Headers[$headersLevel-2], $item.Headers[$headersLevel-1]) : @($item.Headers[$headersLevel-1])

            $final += [PSCustomObject]@{
                Id = $item.Id
                Title = $item.Title
                Headers = $headers
            }
        }
        return ConvertTo-Json $final -Depth 10
    }

    [string] ToJsonGrouped() {
        [string[]] $lastHeaders = ($this.items[0]).Headers
        [string] $headersPath = ""
        $final = @()
        $groupItems = @()

        foreach ($item in $this.items) {
            $headersLevel = $lastHeaders.Count
            $headersPath = $headersLevel -ge 4 ? ($lastHeaders[$headersLevel-2] + " | " + $lastHeaders[$headersLevel-1]) : $lastHeaders[$headersLevel-1]

            $isSameGroup = -not (Compare-Object $item.Headers $lastHeaders)
            if (-not $isSameGroup) {
                $final += [PSCustomObject]@{
                    $headersPath = $groupItems
                }
                $lastHeaders = $item.Headers
                $groupItems = @()
            }

            $groupItems += [PSCustomObject]@{
                $item.Id = $item.Title
            }   
        }
        $final += [PSCustomObject]@{
            $headersPath = $groupItems
        }

        return ConvertTo-Json $final -Depth 10
    }
}

function Build-ArchiveItem {
    return [ArchiveItem]::New()
}

function Build-MarkdownElement
{
    <#
    .SYNOPSIS
    Build markdown element for cached tool.

    .DESCRIPTION
    Build markdown element that contains name of tool, set of versions and additional notes.

    .PARAMETER Head
    Header of cached tool markdown element

    .PARAMETER Content
    Array of lines that contains required information about installed tool instances.
    #>

    param
    (
        [String] $Head,
        [Object[]] $Content
    )

    $markdown = New-MDHeader $Head -Level 4
    $markdown += New-MDParagraph -Lines $Content -NoNewLine

    return $markdown
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

function New-MDNewLine {
    param (
        [int] $Count = 1
    )
    $newLineSymbol = [System.Environment]::NewLine
    return $newLineSymbol * $Count
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

function Test-BlankElement {
    param(
        [string] $Markdown
    )

    $splitByLines = $Markdown.Split("`n")
    # Validate entry without version
    $blankVersions = $splitByLines -match "^-" -notmatch "(OS|Image) Version|WSL|Vcpkg|Docker|\d\." | Out-String

    # Validate tables with blank rows
    $blankRows = ""
    for($i = 0; $i -lt $splitByLines.Length; $i++) {
        $addRows= $false
        $table = @()
        if ($splitByLines[$i].StartsWith("#") -and $splitByLines[$i+1].StartsWith("|")) {
            $table += $splitByLines[$i,($i+1),($i+2)]
            $i += 3
            $current = $splitByLines[$i]
            while ($current.StartsWith("|")) {
                $isBlankRow = $current.Substring(1, $current.LastIndexOf("|") - 2).Split("|").Trim() -contains ""
                if ($isBlankRow) {
                    $table += $current
                    $addRows = $true
                }
                $current = $splitByLines[++$i]
            }
            if ($addRows) {
                $blankRows += $table | Out-String
            }
        }
    }

    # Display report
    $isReport = $false
    if ($blankVersions) {
        Write-Host "Software list with blank version:`n${blankVersions}"
        $isReport = $true
    }
    if ($blankRows) {
        Write-Host "Tables with blank rows:`n${blankRows}"
        $isReport = $true
    }
    if ($isReport) {
        exit 1
    }
}

function Take-Part {
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
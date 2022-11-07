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


function Run-Command {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $SuppressStderr
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $redirectOutputArguments = If ($SuppressStderr) { "2> /dev/null" } Else { "2>&1" }
    $stdout = & bash -c "${Command} ${redirectOutputArguments}"

    return $stdout
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

function Get-BrewPackageVersion {
    param (
        [string] $CommandName
    )

    (Get-LinkTarget (Get-Command $CommandName).Source | Out-String) -match "(?<version>(\d+.){2}\d+)" | Out-Null 
    $packageVersion = $Matches.Version

    return $packageVersion
}

function Get-CachedToolInstances {
    <#
    .SYNOPSIS
    Returns hashtable of installed cached tools.

    .DESCRIPTION
    Return hashtable that contains versions and architectures for the selected cached tool.

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
    foreach ($version in $versions) {
        $instanceInfo = @{}

        # Create instance hashtable
        [string]$instanceInfo.Path = Join-Path -Path $toolPath -ChildPath $version.Name
        [string]$instanceInfo.Version = $version.Name

        # Get all architectures for current version
        [array]$instanceInfo.Architecture_Array = Get-ChildItem $version.FullName -Name -Directory | Where-Object { $_ -match "^x[0-9]{2}$" }
        [string]$instanceInfo.Architecture = $instanceInfo.Architecture_Array -Join ", "

        # Add (default) postfix to version name, in case if current version is in environment path
        if (-not ([string]::IsNullOrEmpty($VersionCommand))) {
            $defaultVersion = $(& ($Name.ToLower()) $VersionCommand 2>&1)
            $defaultToolVersion = $defaultVersion   | Select-String -Pattern "\d+\.\d+\.\d+" -AllMatches `
                                                    | ForEach-Object { $_.Matches.Value }

            if ([version]$version.Name -eq [version]$defaultToolVersion) {
                $instanceInfo.Version += " (Default)"
            }
        }

        $toolInstances += $instanceInfo
    }

    return $toolInstances
}
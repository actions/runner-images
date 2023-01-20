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

function Get-AptSourceRepository {
    param([String] $PackageName)

    $sourceUrl = Get-Content "$PSScriptRoot/../helpers/apt-sources.txt" | Select-String -Pattern $PackageName | Take-OutputPart -Part (1..3)
    return $sourceUrl
}

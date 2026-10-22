function Get-StringPart {
    param (
        [Parameter(ValueFromPipeline)]
        [string] $ToolOutput,
        [string] $Delimiter = " ",
        [int[]] $Part
    )

    $parts = $ToolOutput.Split($Delimiter, [System.StringSplitOptions]::RemoveEmptyEntries)
    $selectedParts = $parts[$Part]
    return [string]::Join($Delimiter, $selectedParts)
}

function Get-PathWithLink {
    param (
        [string] $InputPath
    )

    $link = Get-Item $InputPath | Select-Object -ExpandProperty Target
    if (-not [string]::IsNullOrEmpty($link)) {
      return "${InputPath} -> ${link}"
    }
    return "${InputPath}"
}

function Get-OSVersionShort {
    $(Get-OSVersionFull) | Get-StringPart -Delimiter '.' -Part 0,1
}

function Get-OSVersionFull {
    lsb_release -ds | Get-StringPart -Part 1, 2
}

function Get-KernelVersion {
    $kernelVersion = uname -r
    return $kernelVersion
}

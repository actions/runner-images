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

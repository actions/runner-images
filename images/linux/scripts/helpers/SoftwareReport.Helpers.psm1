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
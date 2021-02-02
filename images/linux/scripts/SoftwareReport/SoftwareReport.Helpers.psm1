function Get-Link-Target {
    param (
        [string] $inputPath
    )
    $link = Get-Item $inputPath| Select-Object -ExpandProperty Target
    If ($link) {
      return " -> $link"
    } Else {
      return ""
    }
}

function Get-Path-With-Link {
    param (
        [string] $inputPath
    )
    $link = Get-Link-Target($inputPath)
    return "${inputPath}${link}"
}

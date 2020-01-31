################################################################################
##  File:  Validate-MSYS2.ps1
##  Desc:  Validate MSYS2 installation
################################################################################

$msysCommand = "msys2"

Get-Command $msysCommand -ErrorAction SilentlyContinue -OutVariable commandInfo
if ($commandInfo) {
    Write-Host "$msysCommand is successfully installed"
} else {
    Write-Host "$msysCommand command unavailable"
    exit 1
}

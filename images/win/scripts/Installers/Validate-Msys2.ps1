################################################################################
##  File:  Validate-Msys2.ps1
##  Desc:  Validate Msys2
################################################################################

$msys2BinDir = "C:\msys64\usr\bin"
$msys2mingwDir = "C:\msys64\mingw64\bin"

$installedTools = @(
    "bash",
    "tar",
    "make"
)

Write-Host "Check installed tools in msys2/usr/bin directory"
$installedTools | ForEach-Object {
    $toolName = $_
    try {
        Invoke-Expression "$msys2BinDir\$_ --version"
    } catch {
        Write-Host "$toolName was not installed in MSYS2 bin directory"
        Write-Error $_
        exit 1
    }
}

Write-Host "Check gcc in msys2/mingw64/bin directory"
try {
    Invoke-Expression "$msys2mingwDir\gcc --version"
} catch {
    Write-Host "gcc was not installed in MSYS2 bin directory"
    Write-Error $_
    exit 1
}

# Adding description of the software to Markdown

# $SoftwareName = "MSYS2"
# $(pacman.exe --version).Split([System.Environment]::NewLine)[1] -match "v\d+\.\d+\.\d+"
# $pacmanVersion = $matches[0]

# $Description = @"
# _Pacman version:_ $pacmanVersion<br/>
# "@

# Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

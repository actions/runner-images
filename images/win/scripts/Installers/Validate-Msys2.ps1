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

$installedMinGWTools = @(
    "gcc",
    "cmake"
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

Write-Host "Check installed tools in msys2/mingw/bin directory"
$installedMinGWTools | ForEach-Object {
    $toolName = $_
    try {
        Invoke-Expression "$msys2mingwDir\$_ --version"
    } catch {
        Write-Error "$toolName was not installed in MSYS2 mingw bin directory"
        Write-Error $_
        exit 1
    }
}


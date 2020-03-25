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

# Adding description of the software to Markdown

function Get-ToolVersion {
    param(
        [string] $ToolPath,
        [int] $VersionLineNumber
    )

    $toolRawVersion = Invoke-Expression "$ToolPath --version"
    $toolRawVersion.Split([System.Environment]::NewLine)[$VersionLineNumber] -match "\d+\.\d+(\.\d+)?" | Out-Null
    $toolVersion = $matches[0]
    return $toolVersion
}

$SoftwareName = "MSYS2"
$pacmanVersion = Get-ToolVersion -ToolPath "$msys2BinDir/pacman" -VersionLineNumber 1
$bashVersion = Get-ToolVersion -ToolPath "$msys2BinDir/bash" -VersionLineNumber 0
$gccVersion = Get-ToolVersion -ToolPath "$msys2mingwDir/gcc" -VersionLineNumber 0
$tarVersion = Get-ToolVersion -ToolPath "$msys2BinDir/tar" -VersionLineNumber 0

$Description = @"
_Tool versions_
_pacman:_ $pacmanVersion<br/>
_bash:_ $bashVersion<br/>
_gcc:_ $gccVersion<br/>
_tar:_ $tarVersion<br/>
MSYS2 location: C:\msys64
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

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

function Get-ToolVersion {
    param(
        [string] $ToolPath,
        [int] $VersionLineNumber
    )

    $toolRawVersion = Invoke-Expression "$ToolPath --version"
    $toolRawVersion.Split([System.Environment]::NewLine)[$VersionLineNumber] -match "\d+\.\d+(\.\d+)?"
    $toolVersion = $matches[0]
    return $toolVersion
}

$SoftwareName = "MSYS2"
$pacmanVersion = Get-ToolVersion -ToolPath "$msys2BinDir/pacman" -VersionLineNumber 1
$bashVersion = Get-ToolVersion -ToolPath "$msys2BinDir/bash" -VersionLineNumber 0
$gccVersion = Get-ToolVersion -ToolPath "$msys2mingwDir/gcc" -LineNumber 0
$tarVersion = Get-ToolVersion -ToolPath "$msys2BinDir/tar" -LineNumber 0
$makeVersion = Get-ToolVersion -ToolPath "$msys2BinDir/make" -LineNumber 0
$cmakeVersion = Get-ToolVersion -ToolPath "$msys2mingwDir/cmake" -LineNumber 0

$Description = @"
_Pacman version:_ $pacmanVersion<br/>
_Bash:_ $bashVersion<br/>
_gcc:_ $gccVersion<br/>
_tar:_ $tarVersion<br/>
_make:_ $makeVersion<br/>
_cmake:_ $cmakeVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

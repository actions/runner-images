################################################################################
##  File:  Validate-Clang.ps1
##  Desc:  Validate Clang installation
################################################################################

if (Get-Command -Name 'clang')
{
    Write-Host "clang is successfully installed:"
    clang --version | Write-Host
}
else
{
    Write-Host "clang is not on PATH"
    exit 1
}

if (Get-Command -Name 'clang++')
{
    Write-Host "clang++ is successfully installed:"
    clang++ --version | Write-Host
}
else
{
    Write-Host "clang++ is not on PATH"
    exit 1
}

# Adding description of the software to Markdown

# `clang --version` gives output like:
# clang version 9.0.0 (tags/RELEASE_900/final)
# Target: x86_64-pc-windows-msvc
# Thread model: posix
# InstalledDir: C:\Program Files\LLVM\bin

$SoftwareName = "Clang"
$(clang --version).Split([System.Environment]::NewLine)[0] -match "\d+\.\d+\.\d+"
$Version = $matches[0]

$Description = @"
_Version:_ $Version<br/>
_Environment:_
* PATH: contains location of the LLVM 'bin' directory
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

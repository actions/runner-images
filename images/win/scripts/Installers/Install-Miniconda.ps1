################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
################################################################################

Import-Module -Name ImageHelpers -Force

# Lock to Miniconda 4.6 until we do the work to run `conda init` for the vsts user
# Then we can go back to installing the latest Miniconda
# $url = "https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe"
$url = "https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Windows-x86_64.exe"
$name = $Url.Split('/')[-1]
$destination = "C:\Miniconda"

Install-EXE -Url $url -Name $name -ArgumentList "/S /AddToPath=0 /RegisterPython=0 /D=$destination"
Set-SystemVariable -SystemVariable "CONDA" -Value $destination

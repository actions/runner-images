################################################################################
##  File:  Install-PHP.ps1
##  Desc:  Install PHP
################################################################################
$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

# Install latest PHP in chocolatey
$installDir = "c:\tools\php"
choco install php -y --force --params "/InstallDir:$installDir"

# update path to extensions and enable curl and mbstring extensions
((Get-Content -path $installDir\php.ini -Raw) -replace ';extension=curl','extension=curl' -replace ';extension=mbstring','extension=mbstring' -replace ';extension_dir = "ext"','extension_dir = "ext"') | Set-Content -Path $installDir\php.ini

# Set the PHPROOT environment variable.
setx PHPROOT $installDir /M

# Done
exit 0

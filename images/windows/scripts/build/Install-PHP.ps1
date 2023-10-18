################################################################################
##  File:  Install-PHP.ps1
##  Desc:  Install PHP
################################################################################

# Install latest PHP in chocolatey
$installDir = "c:\tools\php"
$phpMajorMinor = (Get-ToolsetContent).php.version
$phpVersionToInstall = Get-LatestChocoPackageVersion -TargetVersion $phpMajorMinor -PackageName "php"
Choco-Install -PackageName php -ArgumentList "--params", "/InstallDir:$installDir", "--version=$phpVersionToInstall"

# Install latest Composer in chocolatey
Choco-Install -PackageName composer -ArgumentList "--ia", "/DEV=$installDir /PHP=$installDir"

# update path to extensions and enable curl and mbstring extensions, and enable php openssl extensions.
((Get-Content -path $installDir\php.ini -Raw) -replace ';extension=curl','extension=curl' -replace ';extension=mbstring','extension=mbstring' -replace ';extension_dir = "ext"','extension_dir = "ext"' -replace ';extension=openssl','extension=openssl') | Set-Content -Path $installDir\php.ini

# Set the PHPROOT environment variable.
setx PHPROOT $installDir /M

# Invoke Pester Tests
Invoke-PesterTests -TestFile "PHP"

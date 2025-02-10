################################################################################
##  File:  Install-PHP.ps1
##  Desc:  Install PHP
################################################################################

# Install latest PHP in chocolatey
$installDir = "c:\tools\php"
$phpMajorMinor = (Get-ToolsetContent).php.version
$phpVersionToInstall = Resolve-ChocoPackageVersion -PackageName "php" -TargetVersion $phpMajorMinor
Install-ChocoPackage php -ArgumentList "--params", "/InstallDir:$installDir", "--version=$phpVersionToInstall"

# Install latest Composer in chocolatey
Install-ChocoPackage composer -ArgumentList "--install-args", "/DEV=$installDir /PHP=$installDir"

# update path to extensions and enable curl and mbstring extensions, and enable php openssl extensions.
((Get-Content -path $installDir\php.ini -Raw) -replace ';extension=curl','extension=curl' -replace ';extension=mbstring','extension=mbstring' -replace ';extension_dir = "ext"','extension_dir = "ext"' -replace ';extension=openssl','extension=openssl') | Set-Content -Path $installDir\php.ini

# Set the PHPROOT environment variable.
[Environment]::SetEnvironmentVariable("PHPROOT", $installDir, "Machine")

# Invoke Pester Tests
Invoke-PesterTests -TestFile "PHP"

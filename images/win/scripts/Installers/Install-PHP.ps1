################################################################################
##  File:  Install-PHP.ps1
##  Desc:  Install PHP
################################################################################

# Get latest PHP-7.4
$url = "https://raw.githubusercontent.com/chocolatey-community/chocolatey-coreteampackages/master/automatic/php/php.json"
$phpVersion = [System.Net.WebClient]::new().DownloadString($url) | ConvertFrom-Json
$latestPHPVersion = $phpVersion.'7.4'

# Install latest PHP in chocolatey
$installDir = "c:\tools\php"
Choco-Install -PackageName php -ArgumentList "--version=$latestPHPVersion","--force", "--params", "/InstallDir:$installDir"

# Install latest Composer in chocolatey
Choco-Install -PackageName composer -ArgumentList "--ia", "/DEV=$installDir /PHP=$installDir"

# update path to extensions and enable curl and mbstring extensions, and enable php openssl extensions.
((Get-Content -path $installDir\php.ini -Raw) -replace ';extension=curl','extension=curl' -replace ';extension=mbstring','extension=mbstring' -replace ';extension_dir = "ext"','extension_dir = "ext"' -replace 'extension=";php_openssl.dll"','extension_dir = "php_openssl.dll"') | Set-Content -Path $installDir\php.ini

# Set the PHPROOT environment variable.
setx PHPROOT $installDir /M

# Invoke Pester Tests
Invoke-PesterTests -TestFile "PHP"

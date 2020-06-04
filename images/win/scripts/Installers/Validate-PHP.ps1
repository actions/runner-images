################################################################################
##  File:  Validate-PHP.ps1
##  Desc:  Validate PHP
################################################################################

# Function that gets the version of php at the specified path
function Get-PHPVersion
{
    Param
    (
        [String]$phpRootPath
    )

    $env:Path = "$phpRootPath;" + $env:Path
    if($($(php --version)| Out-String) -match 'PHP (?<version>.*) (.*cli).*')
    {
        $phpVersion = $Matches.version
        Write-Host "PHP version at $phpRootPath is $phpVersion"
        exit 0
    }

    Write-Host "Unable to determine PHP version at " + $phpRootPath
    exit 1
}

# Verify that php.exe is on the path
if(Get-Command -Name 'php')
{
    Write-Host "$(php --version) is on the path."
}
else
{
    Write-Host "php is not on the path."
    exit 1
}

# Verify that composer.exe is on the path
if(Get-Command -Name 'composer')
{
    Write-Host "$(composer --version) is on the path."
}
else
{
    Write-Host "composer is not on the path."
    exit 1
}

# Get available versions of PHP
Get-PHPVersion -phpRootPath "C:\tools\php72"

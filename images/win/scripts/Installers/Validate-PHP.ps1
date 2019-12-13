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
        return $phpVersion
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

# Get available versions of PHP
$phpVersionOnPath = Get-PHPVersion -phpRootPath "C:\tools\php72"

# Add details of available versions in Markdown
$SoftwareName = "PHP (x64)"
$Description = @"
#### $phpVersionOnPath

_Environment:_
* PATH: contains the location of php.exe version $phpVersionOnPath
* PHPROOT: root directory of the PHP $phpVersionOnPath installation
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

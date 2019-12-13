################################################################################
##  File:  Validate-Cmake.ps1
##  Desc:  Validate Cmake
################################################################################

if(Get-Command -Name 'cmake')
{
    Write-Host "Cmake $(cmake -version) on path"
}
else
{
    Write-Host 'cmake not on path'
    exit 1
}


if( $( $(cmake -version) | Out-String) -match  'cmake version (?<version>.*).*' )
{
   $cmakeVersion = $Matches.version.Trim()
}

# Adding description of the software to Markdown
$SoftwareName = "Cmake"

$Description = @"
_Version:_ $cmakeVersion<br/>
_Environment:_
* PATH: contains location of cmake.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

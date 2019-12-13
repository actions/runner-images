################################################################################
##  File:  Validate-Svn.ps1
##  Desc:  Validate Subversion
################################################################################

if(Get-Command -Name 'svn')
{
    Write-Host "Subversion $(svn --version --quiet) is on the path."
}
else
{
    Write-Host "Subversion is not on the path."
    exit 1
}


$svnVersion = $(svn --version --quiet)

# Adding description of the software to Markdown
$SoftwareName = "Subversion"

$Description = @"
_Version:_ $svnVersion<br/>
_Environment:_
* PATH: contains location of svn.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

################################################################################
##  File:  Validate-NET472.ps1
##  Desc:  Validate .NET 4.7.2
################################################################################

Import-Module -Name ImageHelpers -Force

# For reference, visit https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
if(Get-ChildItem "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Get-ItemPropertyValue -Name Release | ForEach-Object { $_ -ge 461814 })
{
    $version = Get-ChildItem "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Get-ItemPropertyValue -Name Version
    Write-Host "Installed .Net version " $version
}
else {
    Write-Host ".Net 472 not found"
    exit 1
}


# Adding description of the software to Markdown
$SoftwareName = ".NET 4.7.2"

$Description = @"
_Version:_ $version
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

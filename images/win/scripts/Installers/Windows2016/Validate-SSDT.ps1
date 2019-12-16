################################################################################
##  File:  Validate-SSDT.ps1
##  Desc:  Validate SQL Server Data Tools for Windows
################################################################################

Import-Module -Name ImageHelpers -Force

function Get-SSDTExtensionPackage {
    $vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
    $instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

    if($instanceFolders -is [array])
    {
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path ($instanceFolders.FullName + '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $SsdtPackage = $state.packages | where { $_.id -eq "SSDT" }
    return $SsdtPackage
}


$SsdtPackage   = Get-SSDTExtensionPackage

if($SsdtPackage){
    Write-Host "SSDT version" $SsdtPackage.version "installed"
}
else {
    Write-Host "SSDT is not installed"
    exit 1
}


# Adding description of the software to Markdown
$SoftwareName = "SQL Server Data Tools for VS 2017"

$Description = @"
_Version:_ $($SsdtPackage.version)<br/>

The following components are installed:

* SQL Server Data Tools
* SQL Server Analysis Services Designer
* SQL Server Integration Services Designer
* SQL Server Reporting Services Designers
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

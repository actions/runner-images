################################################################################
##  File:  Validate-WDK.ps1
##  Desc:  Validate the installation of the Windows Driver Kit
################################################################################

function Get-WDKExtensionPackage {
    $vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
    $instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

    if($instanceFolders -is [array])
    {
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path ($instanceFolders.FullName + '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $WDKPackageVersion = ($state.packages | where { $_.id -eq "Microsoft.Windows.DriverKit" }).version

    if (!$WDKPackageVersion)
    {
        Write-Host "WDK package for Visual studio was not found"
        exit 1
    }

    return $WDKPackageVersion
}

function Get-WDKVersion
{
    $WDKVersion = (Get-WmiObject Win32_Product -Filter "Name = 'Windows Driver Kit'").version

    if (!$WDKVersion)
    {
        Write-Host "WDK was not found"
        exit 1
    }

    return $WDKVersion
}

$WDKVersion = Get-WDKVersion
$WDKPackageVersion = Get-WDKExtensionPackage

# Adding description of the software to Markdown
$SoftwareName = "Windows Driver Kit"

$Description = @"
_WDK Version:_ $WDKVersion<br/>
_WDK Visual Studio Extension Version:_ $WDKPackageVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

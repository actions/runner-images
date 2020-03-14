################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Import-Module -Name ImageHelpers -Force;

choco install wixtoolset -y --force

if(Test-IsWin19)
{
    $extensionUrl = "https://wixtoolset.gallerycdn.vsassets.io/extensions/wixtoolset/wixtoolsetvisualstudio2019extension/1.0.0.4/1563296438961/Votive2019.vsix"
    $extensionName = "Votive2019.vsix"
    $VSver = "2019"
}
else
{
    $extensionUrl = "https://robmensching.gallerycdn.vsassets.io/extensions/robmensching/wixtoolsetvisualstudio2017extension/0.9.21.62588/1494013210879/250616/4/Votive2017.vsix"
    $extensionName = "Votive2017.vsix"
    $VSver = "2017"
}

#Installing VS extension 'Wix Toolset Visual Studio 2019 Extension'
Install-VsixExtension -Url $extensionUrl -Name $extensionName -VSversion $VSver

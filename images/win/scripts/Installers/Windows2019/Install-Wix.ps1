################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Import-Module -Name ImageHelpers -Force;

choco install wixtoolset -y --force

#Installing VS extension 'Wix Toolset Visual Studio 2019 Extension'
Install-VsixExtension -Url 'https://wixtoolset.gallerycdn.vsassets.io/extensions/wixtoolset/wixtoolsetvisualstudio2019extension/1.0.0.4/1563296438961/Votive2019.vsix' -Name 'Votive2019.vsix'
#return $exitCode

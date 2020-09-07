################################################################################
##  File:  Install-InstallerProjects.ps1
##  Desc:  Install the InstallerProjects Visual Studio Extension
################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerProjectsUrl = 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualStudioClient/vsextensions/MicrosoftVisualStudio2017InstallerProjects/0.9.8/vspackage'
Install-VsixExtension -Url $InstallerProjectsUrl -name "InstallerProjects.vsix" -VSversion "2019"

Invoke-PesterTests -TestFile "InstallerProjects"
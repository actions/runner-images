################################################################################
##  File:  Install-VS2019.ps1
##  Desc:  Install Visual Studio 2019
################################################################################
$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

$WorkLoads = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | `
    Select-Object -ExpandProperty workloads | ForEach-Object { "-add $_" }
$WorkLoads += "--remove Component.CPython3.x64"

$ReleaseInPath = "Enterprise"
$BootstrapperUrl = "https://aka.ms/vs/16/release/vs_${ReleaseInPath}.exe"

# Install VS
Install-VisualStudio -BootstrapperUrl $BootstrapperUrl -WorkLoads $WorkLoads

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if ($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

$version = Get-VisualStudioVersion
$VSInstallRoot = "C:\Program Files (x86)\Microsoft Visual Studio\2019\$ReleaseInPath"
Write-Host "Visual Studio version ${version} installed"

# Initialize Visual Studio Experimental Instance
& "$VSInstallRoot\Common7\IDE\devenv.exe" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$VSInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

# Install Windows 10 SDK version 10.0.14393.795
$sdkUrl = "https://go.microsoft.com/fwlink/p/?LinkId=838916"
$sdkFileName = "sdksetup14393.exe"
$argumentList = ("/q", "/norestart", "/ceip off", "/features OptionId.WindowsSoftwareDevelopmentKit")

Install-Binary -Url $sdkUrl -Name $sdkFileName -ArgumentList $argumentList

Invoke-PesterTests -TestFile "VisualStudio"
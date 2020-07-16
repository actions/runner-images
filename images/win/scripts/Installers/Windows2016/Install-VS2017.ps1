################################################################################
##  File:  Install-VS2017.ps1
##  Desc:  Install Visual Studio 2017
################################################################################

$ErrorActionPreference = "Stop"

$toolset = Get-ToolsetContent
$requiredComponents = $toolset.visualStudio.workloads | ForEach-Object { "--add $_" }
$workLoads = @(
	"--allWorkloads --includeRecommended"
	$requiredComponents
	"--remove Component.CPython3.x64"
)
$workLoadsArgument = [String]::Join(" ", $workLoads)

$releaseInPath = $toolset.visualStudio.edition
$bootstrapperUrl = "https://aka.ms/vs/15/release/vs_${releaseInPath}.exe"

# Install VS
Install-VisualStudio -BootstrapperUrl $bootstrapperUrl -WorkLoads $workLoadsArgument

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if ($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

$visualStudioVersion = $toolset.visualStudio.version
$vsInstallRoot = Get-VisualStudioPath -Version $visualStudioVersion -Edition $releaseInPath

# Initialize Visual Studio Experimental Instance for integration testing
& "$vsInstallRoot\Common7\IDE\devenv.exe" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Wait-Process

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

Invoke-PesterTests -TestFile "VisualStudio"
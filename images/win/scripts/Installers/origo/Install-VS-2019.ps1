################################################################################
##  File:  Install-VS.ps1
##  Desc:  Install Visual Studio
################################################################################

#$toolset = Get-ToolsetContent
if (-not (Test-Path -Path "C:\image\toolsetVS.json")) {
	Write-Host "toolsetVS.json not found"
    exit 1
}
else {
	$toolset = Get-Content -Path "C:\image\toolsetVS.json" -Raw | ConvertFrom-Json
}

$requiredComponents = $toolset.visualStudio.workloads | ForEach-Object { "--add $_" }
$workLoads = @(
	"--allWorkloads --includeRecommended"
	$requiredComponents
	"--remove Component.CPython3.x64"
)
$workLoadsArgument = [String]::Join(" ", $workLoads)

$releaseInPath = $toolset.visualStudio.edition
$subVersion = $toolset.visualStudio.subversion
$channel = $toolset.visualStudio.channel
$bootstrapperUrl = "https://aka.ms/vs/${subVersion}/${channel}/vs_${releaseInPath}.exe"

# Install VS
Install-VisualStudio -BootstrapperUrl $bootstrapperUrl -WorkLoads $workLoadsArgument

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

#Invoke-PesterTests -TestFile "VisualStudio"
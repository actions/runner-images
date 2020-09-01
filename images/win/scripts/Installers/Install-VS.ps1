################################################################################
##  File:  Install-VS.ps1
##  Desc:  Install Visual Studio and build tools
################################################################################

$ErrorActionPreference = "Stop"

$toolset = Get-ToolsetContent
$requiredComponents = $toolset.visualStudio.workloads | ForEach-Object { "--add $_" }
$buildToolsRequiredComponents = $toolset.visualStudio.buildtools_workloads | ForEach-Object { "--add $_" }
$workLoads = @(
	"--allWorkloads --includeRecommended"
	$requiredComponents
	"--remove Component.CPython3.x64"
)
$workLoadsArgument = [String]::Join(" ", $workLoads)
$buildToolsWorkloads= @(
	"--includeRecommended"
	$buildToolsRequiredComponents
)
$buildWorkLoadsArgument = [String]::Join(" ", $buildToolsWorkloads)

$releaseInPath = $toolset.visualStudio.edition
$subVersion = $toolset.visualStudio.subversion
$bootstrapperUrl = "https://aka.ms/vs/${subVersion}/release/vs_${releaseInPath}.exe"
$buildbootstrapperUrl = "https://aka.ms/vs/${subVersion}/release/vs_buildtools.exe"

# Install VS and VS Build tools
Install-VisualStudio -BootstrapperUrl $bootstrapperUrl -WorkLoads $workLoadsArgument
Install-VisualStudio -BootstrapperUrl $buildbootstrapperUrl -WorkLoads $buildWorkLoadsArgument

$vsInstallRoot = (Get-VisualStudioProduct -ProductType "VisualStudio").InstallationPath

# Initialize Visual Studio Experimental Instance
& "$vsInstallRoot\Common7\IDE\devenv.exe" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

if (Test-IsWin19) {
	# Install Windows 10 SDK version 10.0.14393.795
	$sdkUrl = "https://go.microsoft.com/fwlink/p/?LinkId=838916"
	$sdkFileName = "sdksetup14393.exe"
	$argumentList = ("/q", "/norestart", "/ceip off", "/features OptionId.WindowsSoftwareDevelopmentKit")
	Install-Binary -Url $sdkUrl -Name $sdkFileName -ArgumentList $argumentList
}

Invoke-PesterTests -TestFile "VisualStudio"
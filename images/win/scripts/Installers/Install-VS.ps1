################################################################################
##  File:  Install-VS.ps1
##  Desc:  Install Visual Studio
################################################################################

$toolset = Get-ToolsetContent
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

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if ($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

if (Test-IsWin19) {
	# Install Windows 10 SDK version 10.0.14393.795
	$sdkUrl = "https://go.microsoft.com/fwlink/p/?LinkId=838916"
	$sdkFileName = "sdksetup14393.exe"
	$argumentList = ("/q", "/norestart", "/ceip off", "/features OptionId.WindowsSoftwareDevelopmentKit")
	Install-Binary -Url $sdkUrl -Name $sdkFileName -ArgumentList $argumentList

	# Install Windows 11 SDK version 10.0.22621.0
        $sdkUrl = "https://go.microsoft.com/fwlink/p/?linkid=2196241"
        $sdkFileName = "sdksetup22621.exe"
        $argumentList = ("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64")
        Install-Binary -Url $sdkUrl -Name $sdkFileName -ArgumentList $argumentList
}

if (Test-IsWin22) {
    # Install Windows 10 SDK version 10.0.17763
    $sdkUrl = "https://go.microsoft.com/fwlink/p/?LinkID=2033908"
    $sdkFileName = "sdksetup17763.exe"
    $argumentList = ("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64")
    Install-Binary -Url $sdkUrl -Name $sdkFileName -ArgumentList $argumentList
}

Invoke-PesterTests -TestFile "VisualStudio"

################################################################################
##  File:  Install-VS2019.ps1
##  Desc:  Install Visual Studio 2019
################################################################################
$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

$WorkLoads = '--allWorkloads --includeRecommended ' + `
              '--add Component.Dotfuscator ' + `
              '--add Component.Linux.CMake ' + `
              '--add Component.UnityEngine.x64 ' + `
              '--add Component.UnityEngine.x86 ' + `
              '--add Component.Unreal.Android ' + `
              '--add Microsoft.Component.Azure.DataLake.Tools ' + `
              '--add Microsoft.Component.CookiecutterTools ' + `
              '--add Microsoft.Component.PythonTools.Miniconda ' + `
              '--add Microsoft.Component.PythonTools.Web ' + `
              '--add Microsoft.Component.VC.Runtime.UCRTSDK ' + `
              '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
              '--add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools ' + `
              '--add Microsoft.Net.Component.4.7.2.SDK ' + `
              '--add Microsoft.Net.Component.4.7.2.TargetingPack ' + `
              '--add Microsoft.Net.ComponentGroup.4.7.2.DeveloperTools ' + `
              '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
              '--add Microsoft.VisualStudio.Component.AspNet45 ' + `
              '--add Microsoft.VisualStudio.Component.Azure.Kubernetes.Tools ' + `
              '--add Microsoft.VisualStudio.Component.Azure.MobileAppsSdk ' + `
              '--add Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools ' + `
              '--add Microsoft.VisualStudio.Component.Azure.Storage.AzCopy ' + `
              '--add Microsoft.VisualStudio.Component.Debugger.JustInTime ' + `
              '--add Microsoft.VisualStudio.Component.DslTools ' + `
              '--add Microsoft.VisualStudio.Component.EntityFramework ' + `
              '--add Microsoft.VisualStudio.Component.FSharp.Desktop ' + `
              '--add Microsoft.VisualStudio.Component.LinqToSql ' + `
              '--add Microsoft.VisualStudio.Component.SQL.SSDT ' + `
              '--add Microsoft.VisualStudio.Component.PortableLibrary ' + `
              '--add Microsoft.VisualStudio.Component.Sharepoint.BuildTools ' + `
              '--add Microsoft.VisualStudio.Component.TeamOffice ' + `
              '--add Microsoft.VisualStudio.Component.TeamOffice.BuildTools ' + `
              '--add Microsoft.VisualStudio.Component.TestTools.CodedUITest ' + `
              '--add Microsoft.VisualStudio.Component.TestTools.WebLoadTest ' + `
              '--add Microsoft.VisualStudio.Component.UWP.VC.ARM64 ' + `
              '--add Microsoft.VisualStudio.Component.VC.140 ' + `
              '--add Microsoft.VisualStudio.Component.VC.ATL.ARM ' + `
              '--add Microsoft.VisualStudio.Component.VC.ATLMFC ' + `
              '--add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.CLI.Support ' + `
              '--add Microsoft.VisualStudio.Component.VC.CMake.Project ' + `
              '--add Microsoft.VisualStudio.Component.VC.DiagnosticTools ' + `
              '--add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset ' + `
              '--add Microsoft.VisualStudio.Component.VC.MFC.ARM ' + `
              '--add Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.MFC.ARM64 ' + `
              '--add Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.Redist.MSM ' + `
              '--add Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest ' + `
              '--add Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141 ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.x86.x64 ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ATL ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ATL.ARM.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ATL.ARM64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.MFC ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.MFC.ARM.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.MFC.ARM64.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre ' + `
              '--add Microsoft.VisualStudio.Component.VC.14.25.x86.x64 ' + `
              '--add Microsoft.VisualStudio.Component.Windows10SDK.16299 ' + `
              '--add Microsoft.VisualStudio.Component.Windows10SDK.17134 ' + `
              '--add Microsoft.VisualStudio.Component.Windows10SDK.17763 ' + `
              '--add Microsoft.VisualStudio.Component.Windows10SDK.18362 ' + `
              '--add Microsoft.VisualStudio.Component.Windows10SDK.19041 ' + `
              '--add Microsoft.VisualStudio.Component.WinXP ' + `
              '--add Microsoft.VisualStudio.Component.Workflow.BuildTools ' + `
              '--add Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices ' + `
              '--add Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools ' + `
              '--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang ' + `
              '--add Microsoft.VisualStudio.ComponentGroup.Web.CloudTools ' + `
              '--add Microsoft.VisualStudio.Workload.Azure ' + `
              '--add Microsoft.VisualStudio.Workload.Data ' + `
              '--add Microsoft.VisualStudio.Workload.DataScience ' + `
              '--add Microsoft.VisualStudio.Workload.ManagedDesktop ' + `
              '--add Microsoft.VisualStudio.Workload.ManagedGame ' + `
              '--add Microsoft.VisualStudio.Workload.NativeCrossPlat ' + `
              '--add Microsoft.VisualStudio.Workload.NativeDesktop ' + `
              '--add Microsoft.VisualStudio.Workload.NativeGame ' + `
              '--add Microsoft.VisualStudio.Workload.NativeMobile ' + `
              '--add Microsoft.VisualStudio.Workload.NetCoreTools ' + `
              '--add Microsoft.VisualStudio.Workload.NetCrossPlat ' + `
              '--add Microsoft.VisualStudio.Workload.NetWeb ' + `
              '--add Microsoft.VisualStudio.Workload.Node ' + `
              '--add Microsoft.VisualStudio.Workload.Office ' + `
              '--add Microsoft.VisualStudio.Workload.Python ' + `
              '--remove Component.CPython3.x64 ' + `
              '--add Microsoft.VisualStudio.Workload.Universal ' + `
              '--add Microsoft.VisualStudio.Workload.VisualStudioExtension ' + `
              '--add Component.MDD.Linux ' + `
              '--add Component.MDD.Linux.GCC.arm'

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

$catalogContent = Get-Content -Path ($instanceFolders.FullName + '\catalog.json')
$catalog = $catalogContent | ConvertFrom-Json
$version = $catalog.info.id
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

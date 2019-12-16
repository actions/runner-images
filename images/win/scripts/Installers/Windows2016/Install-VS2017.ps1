################################################################################
##  File:  Install-VS2017.ps1
##  Desc:  Install Visual Studio 2017
################################################################################

Function InstallVS
{
  Param
  (
    [String]$WorkLoads,
    [String]$Sku,
    [String] $VSBootstrapperURL
  )

  $exitCode = -1

  try
  {
    Write-Host "Enable short name support on Windows needed for Xamarin Android AOT, defaults appear to have been changed in Azure VMs"
    $shortNameEnableProcess = Start-Process -FilePath fsutil.exe -ArgumentList ('8dot3name', 'set', '0') -Wait -PassThru
    $shortNameEnableExitCode = $shortNameEnableProcess.ExitCode

    if ($shortNameEnableExitCode -ne 0)
    {
      Write-Host -Object 'Enabling short name support on Windows failed. This needs to be enabled prior to VS 2017 install for Xamarin Andriod AOT to work.'
      exit $shortNameEnableExitCode
    }

    Write-Host "Downloading Bootstrapper ..."
    Invoke-WebRequest -Uri $VSBootstrapperURL -OutFile "${env:Temp}\vs_$Sku.exe"

    $FilePath = "${env:Temp}\vs_$Sku.exe"
    $Arguments = ('/c', $FilePath, $WorkLoads, '--quiet', '--norestart', '--wait', '--nocache' )

    Write-Host "Starting Install ..."
    $process = Start-Process -FilePath cmd.exe -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 3010)
    {
      Write-Host -Object 'Installation successful'
      return $exitCode
    }
    else
    {
      Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."

      # this wont work because of log size limitation in extension manager
      # Get-Content $customLogFilePath | Write-Host

      exit $exitCode
    }
  }
  catch
  {
    Write-Host -Object "Failed to install Visual Studio. Check the logs for details in $customLogFilePath"
    Write-Host -Object $_.Exception.Message
    exit -1
  }
}

$WorkLoads = '--allWorkloads --includeRecommended ' + `
                '--add Microsoft.Net.Component.4.6.2.SDK ' + `
                '--add Microsoft.Net.Component.4.6.2.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
                '--add Microsoft.Net.Component.4.7.SDK ' + `
                '--add Microsoft.Net.Component.4.7.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
                '--add Microsoft.Net.Component.4.7.1.SDK ' + `
                '--add Microsoft.Net.Component.4.7.1.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.2.DeveloperTools ' + `
                '--add Microsoft.Net.Core.Component.SDK.1x ' + `
                '--add Microsoft.NetCore.1x.ComponentGroup.Web ' + `
                '--add Microsoft.VisualStudio.Component.Azure.Storage.AzCopy ' + `
                '--add Microsoft.VisualStudio.Component.PowerShell.Tools ' + `
                '--add Microsoft.VisualStudio.Component.VC.140 ' + `
                '--add Component.Dotfuscator ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL.ARM ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL.ARM64 ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATLMFC ' + `
                '--add Microsoft.VisualStudio.Component.VC.ClangC2 ' + `
                '--add Microsoft.VisualStudio.Component.VC.CLI.Support ' + `
                '--add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10240 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10586 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.14393 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop ' + `
                '--add Component.Unreal ' + `
                '--add Component.Unreal.Android ' + `
                '--add Component.Android.SDK23 ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.WebLoadTest ' + `
                '--add Microsoft.VisualStudio.Web.Mvc4.ComponentGroup ' + `
                '--add Component.Linux.CMake ' + `
                '--add Microsoft.Component.PythonTools.UWP ' + `
                '--remove Component.CPython3.x64 ' + `
                '--add Microsoft.Component.VC.Runtime.OSSupport ' + `
                '--add Microsoft.VisualStudio.Component.VC.Tools.ARM ' + `
                '--add Microsoft.VisualStudio.ComponentGroup.UWP.VC ' + `
                '--add Microsoft.VisualStudio.Component.VSSDK ' + `
                '--add Microsoft.VisualStudio.Component.LinqToSql ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.CodedUITest ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.Core ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.0 ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.1 ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.2 ' + `
                '--add Microsoft.VisualStudio.Component.VC.Tools.ARM64 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop.arm ' + `
                '--add Microsoft.VisualStudio.Component.DslTools ' + `
                '--add Microsoft.VisualStudio.Component.Windows81SDK ' + `
                '--add Microsoft.VisualStudio.Component.WinXP ' + `
                '--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Win81 ' + `
                '--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.WinXP ' + `
                '--add Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Managed ' + `
                '--add Microsoft.Component.Blend.SDK.WPF ' + `
                '--add Microsoft.Component.VC.Runtime.UCRTSDK ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL.Spectre ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.17134 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.17763 ' + `
                '--add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre '+ `
                '--add Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre ' + `
                '--add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre '

$Sku = 'Enterprise'
$VSBootstrapperURL = 'https://aka.ms/vs/15/release/vs_enterprise.exe'

$ErrorActionPreference = 'Stop'

# Install VS
$exitCode = InstallVS -WorkLoads $WorkLoads -Sku $Sku -VSBootstrapperURL $VSBootstrapperURL

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

$catalogContent = Get-Content -Path ($instanceFolders.FullName + '\catalog.json')
$catalog = $catalogContent | ConvertFrom-Json
$version = $catalog.info.id
$VSInstallRoot = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise"
Write-Host "Visual Studio version" $version "installed"

# Initialize Visual Studio Experimental Instance for integration testing
&"$VSInstallRoot\Common7\IDE\devenv.exe" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Wait-Process

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$VSInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent


# Adding description of the software to Markdown

$SoftwareName = "Visual Studio 2017 Enterprise"

$Description = @"
_Version:_ $version<br/>
_Location:_ $VSInstallRoot

The following workloads including required and recommended components are installed with Visual Studio 2017:

* Universal Windows Platform development
* .NET desktop development
* Desktop development with C++
* ASP.NET and web development
* Azure development
* Node.js development
* Data storage and processing
* Data science and analytical applications *
* Game development with Unity *
* Linux development with C++ *
* Game development with C++ *
* Mobile development with C++ *
* Office/SharePoint development
* Mobile development with .NET
* .NET Core cross-platform development
* Visual Studio extension development *
* Python development *
* Mobile development with JavaScript *

In addition the following optional components are installed:

"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

# Adding explicitly added Workloads details to markdown by parsing $Workloads
Add-ContentToMarkdown -Content $($WorkLoads.Split('--') | % { if( ($_.Split(" "))[0] -like "add") { "* " +($_.Split(" "))[1] }  } )



exit $exitCode

################################################################################
##  File:  Install-VisualStudio.ps1
##  Desc:  Install Visual Studio
################################################################################

$toolset = Get-ToolsetContent

# Install VS
Install-VisualStudio `
    -Version $toolset.visualStudio.subversion `
    -Edition $toolset.visualStudio.edition `
    -Channel $toolset.visualStudio.channel `
    -RequiredComponents $toolset.visualStudio.workloads `
    -ExtraArgs "--allWorkloads --includeRecommended --remove Component.CPython3.x64" `
    -SignatureThumbprint $toolset.visualStudio.signature

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if ($instanceFolders -is [array]) {
    Write-Host "More than one instance installed"
    exit 1
}

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

if (Test-IsWin19) {
    # Install Windows 10 SDK version 10.0.14393.795
    Install-Binary -Type EXE `
        -Url 'https://go.microsoft.com/fwlink/p/?LinkId=838916' `
        -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.WindowsSoftwareDevelopmentKit") `
        -ExpectedSignature 'C91545B333C52C4465DE8B90A3FAF4E1D9C58DFA'
    
    # Install Windows 11 SDK version 10.0.22621.0
    Install-Binary -Type EXE `
        -Url 'https://go.microsoft.com/fwlink/p/?linkid=2196241' `
        -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64") `
        -ExpectedSignature 'E4C5C5FCDB68B930EE4E19BC25D431EF6D864C51'   
}

if (Test-IsWin22) {    
    # Install Windows 10 SDK version 10.0.17763
    Install-Binary -Type EXE `
        -Url 'https://go.microsoft.com/fwlink/p/?LinkID=2033908' `
        -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64") `
        -ExpectedSignature '7535269B94C1FEA4A5EF6D808E371DA242F27936'
}

Invoke-PesterTests -TestFile "VisualStudio"

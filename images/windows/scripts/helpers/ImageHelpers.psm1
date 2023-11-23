[CmdletBinding()]
param()

. $PSScriptRoot\PathHelpers.ps1
. $PSScriptRoot\InstallHelpers.ps1
. $PSScriptRoot\ChocoHelpers.ps1
. $PSScriptRoot\VisualStudioHelpers.ps1

Export-ModuleMember -Function @(
    'Mount-RegistryHive'
    'Dismount-RegistryHive'
    'Add-MachinePathItem'
    'Add-DefaultPathItem'
    'Install-Binary'
    'Install-VisualStudio'
    'Get-ToolsetContent'
    'Get-TCToolVersionPath'
    'Get-TCToolPath'
    'Start-DownloadWithRetry'
    'Get-VsixExtenstionFromMarketplace'
    'Install-VSIXFromFile'
    'Install-VSIXFromUrl'
    'Get-VSExtensionVersion'
    'Get-WinVersion'
    'Test-IsWin22'
    'Test-IsWin19'
    'Install-ChocoPackage'
    'Send-RequestToCocolateyPackages'
    'Resolve-ChocoPackageVersion'
    'Get-GitHubPackageDownloadUrl'
    'Expand-7ZipArchive'
    'Invoke-SBWithRetry'
    'Get-VsCatalogJsonPath'
    'Get-AndroidPackages'
    'Get-AndroidPlatformPackages'
    'Get-AndroidBuildToolPackages'
    'Get-AndroidInstalledPackages'
    'Get-VisualStudioInstance'
    'Get-VisualStudioComponents'
    'Get-WindowsUpdateStates'
    'Use-ChecksumComparison'
    'Get-HashFromGitHubReleaseBody'
    'Test-FileSignature'
    'Update-Environment'
)

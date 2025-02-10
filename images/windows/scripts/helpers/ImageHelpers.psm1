[CmdletBinding()]
param()

. $PSScriptRoot\AndroidHelpers.ps1
Export-ModuleMember -Function @(
    'Get-AndroidPackages'
    'Get-AndroidPlatformPackages'
    'Get-AndroidBuildToolPackages'
    'Get-AndroidInstalledPackages'
)

. $PSScriptRoot\ChocoHelpers.ps1
Export-ModuleMember -Function @(
    'Install-ChocoPackage'
    'Resolve-ChocoPackageVersion'
)

. $PSScriptRoot\InstallHelpers.ps1
Export-ModuleMember -Function @(
    'Install-Binary'
    'Invoke-DownloadWithRetry'
    'Get-ToolsetContent'
    'Get-TCToolPath'
    'Get-TCToolVersionPath'
    'Test-IsWin25'
    'Test-IsWin22'
    'Test-IsWin19'
    'Expand-7ZipArchive'
    'Get-WindowsUpdateStates'
    'Invoke-ScriptBlockWithRetry'
    'Get-GithubReleasesByVersion'
    'Resolve-GithubReleaseAssetUrl'
    'Get-ChecksumFromGithubRelease'
    'Get-ChecksumFromUrl'
    'Test-FileChecksum'
    'Test-FileSignature'
    'Update-Environment'
)

. $PSScriptRoot\PathHelpers.ps1
Export-ModuleMember -Function @(
    'Mount-RegistryHive'
    'Dismount-RegistryHive'
    'Add-MachinePathItem'
    'Add-DefaultPathItem'
)

. $PSScriptRoot\VisualStudioHelpers.ps1
Export-ModuleMember -Function @(
    'Install-VisualStudio'
    'Get-VisualStudioInstance'
    'Get-VisualStudioComponents'
    'Get-VsixInfoFromMarketplace'
    'Install-VSIXFromFile'
    'Install-VSIXFromUrl'
    'Get-VSExtensionVersion'
)

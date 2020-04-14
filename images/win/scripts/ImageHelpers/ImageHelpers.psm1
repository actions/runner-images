[CmdletBinding()]
param()

. $PSScriptRoot\PathHelpers.ps1
. $PSScriptRoot\InstallHelpers.ps1
. $PSScriptRoot\MarkdownHelpers.ps1
. $PSScriptRoot\ChocoHelpers.ps1

Export-ModuleMember -Function @(
    'Test-MachinePath'
    'Get-MachinePath'
    'Set-MachinePath'
    'Add-MachinePathItem'
    'Get-SystemVariable'
    'Set-SystemVariable'
    'Install-MSI'
    'Install-EXE'
    'Get-ToolcachePackages'
    'Get-ToolsByName'
    'Add-ContentToMarkdown'
    'Add-SoftwareDetailsToMarkdown'
    'Stop-SvcWithErrHandling'
    'Set-SvcWithErrHandling'
    'Start-DownloadWithRetry'
    'Install-VsixExtension'
    'Get-VSExtensionVersion'
    'Get-WinVersion'
    'Test-IsWin19'
    'Test-IsWin16'
    'Install-Choco'
)

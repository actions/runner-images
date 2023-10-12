################################################################################
##  File:  Configure-Powershell.ps1
##  Desc:  Manage PowerShell configuration
################################################################################

#region System
Write-Host "Setup PowerShellGet"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# Specifies the installation policy
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

Write-Host 'Warmup PSModuleAnalysisCachePath (speedup first powershell invocation by 20s)'
$PSModuleAnalysisCachePath = 'C:\PSModuleAnalysisCachePath\ModuleAnalysisCache'

[Environment]::SetEnvironmentVariable('PSModuleAnalysisCachePath', $PSModuleAnalysisCachePath, [System.EnvironmentVariableTarget]::Machine)
# make variable to be available in the current session
${env:PSModuleAnalysisCachePath} = $PSModuleAnalysisCachePath

$null = New-Item -Path $PSModuleAnalysisCachePath  -ItemType 'File'  -Force
#endregion

#region User (current user, image generation only)
if (-not (Test-Path $profile)) {
    New-Item $profile -ItemType File -Force
}
  
@" 
  if ( -not(Get-Module -ListAvailable -Name PowerHTML)) {
      Install-Module PowerHTML -Scope CurrentUser 
  } 
  
  if ( -not(Get-Module -Name PowerHTML)) {
      Import-Module PowerHTML
  } 
"@ | Add-Content -Path $profile -Force

#endregion

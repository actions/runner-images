################################################################################
##  File:  Configure-Powershell.ps1
##  Desc:  Manage PowerShell configuration
################################################################################

#region System
Write-Host "Setup PowerShellGet"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# Specifies the installation policy
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
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

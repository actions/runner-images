################################################################################
##  File:  Configure-DeveloperMode.ps1
##  Desc:  Enables Developer Mode by toggling registry setting. Developer Mode is required to enable certain tools (e.g. WinAppDriver). 
################################################################################

# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
$registryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $registryKeyPath)) {
    New-Item -Path $registryKeyPath -ItemType Directory -Force
}

# Add registry value to enable Developer Mode
New-ItemProperty -Path $registryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1

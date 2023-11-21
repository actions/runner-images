$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Import-Module "$env:HELPER_SCRIPTS/Tests.Helpers.psm1" -DisableNameChecking

# Specifies the installation policy
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

# Try to update PowerShellGet before the actual installation
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet -Force

# Install PowerShell modules
$modules = (Get-ToolsetContent).powershellModules

foreach($module in $modules)
{
    $moduleName = $module.name
    Write-Host "Installing ${moduleName} module"

    if ($module.versions)
    {
        foreach ($version in $module.versions)
        {
            Write-Host " - $version"
            Install-Module -Name $moduleName -RequiredVersion $version -Scope AllUsers -SkipPublisherCheck -Force
        }
        continue
    }

    Install-Module -Name $moduleName -Scope AllUsers -SkipPublisherCheck -Force
}

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "PowerShellModules"

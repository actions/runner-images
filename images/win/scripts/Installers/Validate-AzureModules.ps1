################################################################################
##  File:  Validate-AzureModules.ps1
##  Desc:  Validate Azure PowerShell modules
################################################################################

function Validate-AzureModule
{
    param([String]$ModuleName, [String[]]$ModuleVersions)

    foreach($moduleVersion in $moduleVersions)
    {
        $modulePath = "${installPSModulePath}\${moduleName}_${moduleVersion}"
        # Import each module in PowerShell session
        $job = Start-Job -ScriptBlock {
            param($modulePath, $moduleName)

            $env:PsModulePath = "$modulePath;$env:PsModulePath"
            Import-Module -Name $moduleName
            Get-Module -Name $moduleName
        } -ArgumentList $modulePath, $moduleName
        $isError = $job | Wait-Job | Foreach-Object ChildJobs | Where-Object {$_.Error}
        if($isError)
        {
            Write-Host "Required '$moduleName' module '$moduleVersion' version is not present"
            exit 1
        }
        $job | Receive-Job | Select-Object Name,Version,Path
        Remove-Job $job
    }
}

# Modules path
$installPSModulePath = 'C:\Modules'

# Validate Azure modules and versions
$azurermVersions = "2.1.0", "3.8.0", "4.2.1", "5.1.1", "6.7.0", "6.13.1"
Validate-AzureModule -ModuleName AzureRM -ModuleVersions $azurermVersions

$azureVersions = "2.1.0", "3.8.0", "4.2.1", "5.1.1", "5.3.0"
Validate-AzureModule -ModuleName Azure -ModuleVersions $azureVersions

$azVersions = "1.0.0", "1.6.0", "2.3.2", "2.6.0", "3.1.0", "3.5.0", "3.8.0"
Validate-AzureModule -ModuleName Az -ModuleVersions $azVersions

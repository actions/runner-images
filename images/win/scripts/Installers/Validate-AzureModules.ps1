################################################################################
##  File:  Validate-AzureModules.ps1
##  Desc:  Validate Azure PowerShell modules
################################################################################

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

$modulesRootPath = $env:PSMODULES_ROOT_FOLDER

# Get modules content from toolset
$modules = Get-ToolsetContent | Select-Object -ExpandProperty azureModules

foreach ($module in $modules)
{
    foreach ($version in $module.versions)
    {
        $modulePath = Join-Path -Path $modulesRootPath -ChildPath "$($module.name)_${version}"

        Write-Host "Trying to import $($module.name)_${version}..."
        $testJob = Start-Job -ScriptBlock {
            param (
                $modulePath,
                $moduleName
            )

            $env:PsModulePath = "$modulePath;$env:PsModulePath"
            Import-Module -Name $moduleName
            Get-Module -Name $moduleName

        } -ArgumentList $modulePath, $module.name | Out-Null

        $isError = $testJob | Wait-Job | Foreach-Object ChildJobs | Where-Object { $_.Error }
        if ($isError)
        {
            Write-Host "Required $($module.name) module $version version is not present"

            exit 1
        }

        $testJob | Receive-Job | Select-Object Name,Version,Path
        Remove-Job $testJob
    }
}
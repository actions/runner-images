################################################################################
##  File:  Validate-AzureModules.ps1
##  Desc:  Validate Azure PowerShell modules
################################################################################

$ErrorActionPreference = "Stop"

$modulesRootPath = $env:PSMODULES_ROOT_FOLDER

# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules

foreach ($module in $modules)
{
    foreach ($version in $module.versions)
    {
        $moduleName = $module.name
        $modulePath = Join-Path -Path $modulesRootPath -ChildPath "$($module.name)_${version}"

        Write-Host "Trying to import ${moduleName}_${version}..."
        $testJob = Start-Job -ScriptBlock {
            param (
                $modulePath,
                $moduleName
            )

            $env:PsModulePath = "$modulePath;$env:PsModulePath"
            Import-Module -Name $moduleName
            Get-Module -Name $moduleName

        } -ArgumentList $modulePath, $moduleName

        $isError = $testJob | Wait-Job | Foreach-Object ChildJobs | Where-Object { $_.Error }
        if ($isError)
        {
            Write-Host "Required ${moduleName} module ${version} version is not present"

            exit 1
        }

        $testJob | Receive-Job | Select-Object Name,Version,Path
        Remove-Job $testJob
    }
}
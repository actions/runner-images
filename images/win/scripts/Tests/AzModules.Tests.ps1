$modulesRootPath = $env:PSMODULES_ROOT_FOLDER

# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules

foreach ($module in $modules)
{
    Describe "$($module.name)" {
        foreach ($version in $module.versions) {
            $moduleName = $module.name
            $modulePath = Join-Path -Path $modulesRootPath -ChildPath "$($module.name)_${version}"

            Context "$version" {
                $moduleInfo = @{ Name = $moduleName; Path = $modulePath }
                It "Module exists" -TestCases $moduleInfo {
                    $testJob = Start-Job -ScriptBlock {
                        param (
                            $modulePath,
                            $moduleName
                        )

                        $env:PsModulePath = "$modulePath;$env:PsModulePath"
                        Import-Module -Name $moduleName
                        Get-Module -Name $moduleName

                    } -ArgumentList $Path, $Name

                    $isError = $testJob | Wait-Job | Foreach-Object ChildJobs | Where-Object { $_.Error }
                    $isError | Should Not -Exist
                }
            }
        }
    }
}
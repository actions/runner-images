# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules

$modulesRootPath = $env:PSMODULES_ROOT_FOLDER

foreach ($module in $modules) {
    Describe "$($module.name)" {

        if ($module.default) {
            Context "default" {
                $moduleInfo = @{ moduleName = $module.name; moduleDefault = $module.default }
                It "$($module.name) version $($module.default) is default" -TestCases $moduleInfo {
                        $moduleVersion = (Get-Module -ListAvailable -Name $moduleName).Version.ToString()
                        $moduleVersion | Should -Match $moduleDefault
                    }
                }
        }

        foreach ($version in $module.versions) {
            Context "$version" {
                $modulePath = Join-Path -Path $modulesRootPath -ChildPath "$($module.name)_${version}"
                $moduleInfo = @{ moduleName = $module.name; modulePath = $modulePath; expectedVersion = $version }
                It "Module exists" -TestCases $moduleInfo {
                    $testJob = Start-Job -ScriptBlock {
                        param (
                            $modulePath,
                            $moduleName
                        )

                        # Disable warning messages to prevent additional warnings about Az and Azurerm modules in the same session
                        $WarningPreference = "SilentlyContinue"

                        $env:PsModulePath = "$modulePath;$env:PsModulePath"
                        Import-Module -Name $moduleName
                        (Get-Module -Name $moduleName).Version.ToString()

                    } -ArgumentList $modulePath, $moduleName

                    $moduleVersion = $testJob | Wait-Job | Receive-Job
                    Remove-Job $testJob
                    $moduleVersion | Should -Match $expectedVersion
                }
            }
        }
    }
}
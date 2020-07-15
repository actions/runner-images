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
                $moduleInfo = @{ moduleName = $module.name; modulePath = $modulePath; moduleVersion = $version }
                It "Module exists" -TestCases $moduleInfo {
                    $testJob = Start-Job -ScriptBlock {
                        param (
                            $modulePath,
                            $moduleName,
                            $moduleVersion
                        )

                        # Disable warning messages to prevent additional output about unapproved verbs
                        $WarningPreference = "SilentlyContinue"

                        $env:PsModulePath = "$modulePath;$env:PsModulePath"
                        Import-Module -Name $moduleName
                        # There is no module "az" in the az bundle and all submodules version can differ from az version, check the path for Az.Storage module instead
                        if ($moduleName -eq "az")
                        {
                            $isTrue = (Get-Module -ListAvailable -Name Az.Storage).path -match $moduleVersion
                        }
                        else
                        {
                            $isTrue = (Get-Module -ListAvailable -Name $moduleName)[0].Version.ToString() -match $moduleVersion
                        }

                        $isTrue

                    } -ArgumentList $modulePath, $moduleName, $moduleVersion

                    $isTrue = $testJob | Wait-Job | Receive-Job
                    Remove-Job $testJob
                    $isTrue | Should -Be $true
                }
            }
        }
    }
}
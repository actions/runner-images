Describe "AzureModules" {

    $modules = (Get-ToolsetContent).azureModules
    $modulesRootPath = "C:\\Modules"

    foreach ($module in $modules) {
        $moduleName = $module.name

        Context "$moduleName" {

            foreach ($version in $module.versions) {
                $modulePath = Join-Path -Path $modulesRootPath -ChildPath "${moduleName}_${version}"
                $moduleInfo = @{ moduleName = $moduleName; modulePath = $modulePath; expectedVersion = $version }
                It "<expectedVersion> exists in modules directory" -TestCases $moduleInfo {
                    $ScriptBlock = {
                        param ($modulePath, $moduleName)
                        Import-Module ImageHelpers
                        Get-ModuleVersionAsJob -modulePath $modulePath -moduleName $moduleName
                    }
                    if ($moduleName -eq "Az"){
                        Start-Process -FilePath pwsh.exe -ArgumentList "-Command (Invoke-Command -ScriptBlock {$ScriptBlock} -ArgumentList $modulePath, $moduleName)" -Wait -PassThru
                    } else {
                        Start-Process -FilePath powershell.exe -ArgumentList "-Command (Invoke-Command -ScriptBlock {$ScriptBlock} -ArgumentList $modulePath, $moduleName)" -Wait -PassThru
                    }
                    $moduleVersion = Get-Content -Path "$env:TEMP\module-version.txt"
                    Remove-Item -Path "${env:TEMP}\module-version.txt" -Force
                    $moduleVersion | Should -Match $expectedVersion
                }
            }

            if ($module.default) {
                $moduleInfo = @{ moduleName = $moduleName; moduleDefault = $module.default }
                It "<moduleDefault> set as default" -TestCases $moduleInfo {
                        $moduleVersions = Get-Module -ListAvailable -Name $moduleName | ForEach-Object { $_.Version.ToString() }
                        $moduleVersions | Should -Contain $moduleDefault
                }
            }
        }
    }
}

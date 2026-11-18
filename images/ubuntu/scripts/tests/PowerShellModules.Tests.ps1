Describe "PowerShellModules" {
    $modules = (Get-ToolsetContent).powershellModules
    $modulesWithoutVersions = $modules | Where-Object { -not $_.versions } | ForEach-Object {
        @{moduleName = $_.name}
    }

    $modulesWithVersions = $modules | Where-Object { $_.versions } | ForEach-Object {
        $moduleName = $_.name
        $_.versions | ForEach-Object {
            @{moduleName = $moduleName; expectedVersion = $_}
        }
    }

    It "<moduleName> is installed" -TestCases $modulesWithoutVersions {
        Get-Module -Name $moduleName -ListAvailable | Should -BeTrue
    }

    if ($modulesWithVersions) {
        It "<moduleName> with <expectedVersion> is installed" -TestCases $modulesWithVersions {
            (Get-Module -Name $moduleName -ListAvailable).Version -contains $expectedVersion | Should -BeTrue
        }
    }
}

Describe "AzureModules" {
    $modules = (Get-ToolsetContent).azureModules
    $modulesRootPath = "/usr/share"

    foreach ($module in $modules) {
        $moduleName = $module.name

        Context "$moduleName" {
            foreach ($version in $module.versions) {
                $modulePath = Join-Path -Path $modulesRootPath -ChildPath "${moduleName}_${version}"
                $moduleInfo = @{ moduleName = $moduleName; modulePath = $modulePath; expectedVersion = $version }

                It "<expectedVersion> exists in modules directory" -TestCases $moduleInfo {
                    $testJob = Start-Job -ScriptBlock {
                        param (
                            $modulePath,
                            $moduleName
                        )

                        $env:PSModulePath = $modulePath
                        Get-Module -ListAvailable -Name $moduleName | ForEach-Object { $_.Version.ToString() }
                    } -ArgumentList $modulePath, $moduleName

                    $moduleVersions = $testJob | Wait-Job | Receive-Job
                    Remove-Job $testJob
                    $moduleVersions | Should -Contain $expectedVersion
                }
            }
        }
    }
}

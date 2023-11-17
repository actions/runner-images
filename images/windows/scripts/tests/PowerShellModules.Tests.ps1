Describe "PowerShellModules" {
    $modules = (Get-ToolsetContent).powershellModules
    $withoutVersionsModules = $modules | Where-Object {-not $_.versions} | ForEach-Object {
        @{moduleName = $_.name}
    }

    $withVersionsModules = $modules | Where-Object {$_.versions} | ForEach-Object {
        $moduleName = $_.name
        $_.versions | ForEach-Object {
            @{moduleName = $moduleName; expectedVersion = $_}
        }
    }

    It "<moduleName> is installed" -TestCases $withoutVersionsModules {
        Get-Module -Name $moduleName -ListAvailable | Should -BeTrue
    }

    if ($withVersionsModules) {
        It "<moduleName> with <expectedVersion> is installed" -TestCases $withVersionsModules {
            (Get-Module -Name $moduleName -ListAvailable).Version -contains $expectedVersion | Should -BeTrue
        }
    }
}

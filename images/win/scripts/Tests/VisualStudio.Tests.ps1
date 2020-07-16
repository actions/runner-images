Describe "Visual Studio" {
    Context "Basic" {
        It "Catalog.json" {
            $catalogJsonPath = Get-VsCatalogJsonPath
            $catalogJsonPath | Should -Exist
        }

        It "Devenv.exe" {
            $expectedVersion = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty version
            $devenvexePath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\${expectedVersion}\Enterprise\Common7\IDE\devenv.exe"
            $devenvexePath | Should -Exist
        }
    }

    Context "Visual Studio components" {
        $visualStudioComponents = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty workloads
        $testCases = $visualStudioComponents | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }
}
Describe "Visual Studio" {
    Context "Basic" {
        It "Catalog.json" {
            $catalogJsonPath = Get-VsCatalogJsonPath
            $catalogJsonPath | Should -Exist
        }

        It "Devenv.exe" {
            $visualStudioEdition = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty edition
            $visualStudioVersion = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty version
            $vsInstallRoot = Get-VisualStudioPath -Version $visualStudioVersion -Edition $visualStudioEdition
            $devenvexePath = "${vsInstallRoot}\Common7\IDE\devenv.exe"
            $devenvexePath | Should -Exist
        }
    }

    Context "Visual Studio components" {
        $expectedComponents = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty workloads
        $testCases = $expectedComponents | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }
}
Describe "Visual Studio" {
    Context "Basic" {
        It "Catalog.json" {
            Get-VsCatalogJsonPath | Should -Exist
        }

        It "Devenv.exe" {
            $vsInstallRoot = (Get-VisualStudioInstallation -VSInstallType "VS").InstallationPath
            $devenvexePath = "${vsInstallRoot}\Common7\IDE\devenv.exe"
            $devenvexePath | Should -Exist
        }
    }

    Context "Visual Studio components" {
        $expectedComponents = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty workloads
        $testCases = $expectedComponents | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents -VSInstallType "VS" | Select-Object -ExpandProperty Package
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }

    Context "Visual Studio build components" {
        $expectedComponents = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty build_workloads
        $testCases = $expectedComponents | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents -VSInstallType "Build" | Select-Object -ExpandProperty Package
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }
}
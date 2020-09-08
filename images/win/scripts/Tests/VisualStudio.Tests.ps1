Describe "Visual Studio" {
    Context "Basic" {
        It "Catalog.json" {
            Get-VsCatalogJsonPath | Should -Exist
        }

        It "Devenv.exe" {
            $vsInstallRoot = (Get-VisualStudioProduct -ProductType "VisualStudio").InstallationPath
            $devenvexePath = "${vsInstallRoot}\Common7\IDE\devenv.exe"
            $devenvexePath | Should -Exist
        }
    }

    Context "Visual Studio components" {
        $testCases = (Get-ToolsetContent).visualStudio.workloads | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents -ProductType "VisualStudio" | Select-Object -ExpandProperty Package
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }

    Context "Visual Studio Build Tools components" {
        $testCases = (Get-ToolsetContent).visualStudio.buildtools_workloads | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents -ProductType "BuildTools" | Select-Object -ExpandProperty Package
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }
}
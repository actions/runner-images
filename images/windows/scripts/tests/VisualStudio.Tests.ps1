Describe "Visual Studio" {
    Context "Basic" {
        It "Catalog.json" {
            $instanceFolder = Get-Item "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\*" | Select-Object -First 1
            Join-Path $instanceFolder.FullName "catalog.json" | Should -Exist
        }

        It "Devenv.exe" {
            $vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
            $devenvexePath = "${vsInstallRoot}\Common7\IDE\devenv.exe"
            $devenvexePath | Should -Exist
        }
    }

    Context "Visual Studio components" {
        $expectedComponents = Get-ToolsetContent | Select-Object -ExpandProperty visualStudio | Select-Object -ExpandProperty workloads
        $testCases = $expectedComponents | ForEach-Object { @{ComponentName = $_} }
        BeforeAll {
            $installedComponents = Get-VisualStudioComponents | Select-Object -ExpandProperty Package
        }

        It "<ComponentName>" -TestCases $testCases {
            $installedComponents | Should -Contain $ComponentName
        }
    }
}

Describe "Windows 10 SDK" -Skip:((Test-IsWin19) -or (Test-IsWin25)) {
    It "Verifies 17763 SDK is installed" {
        "${env:ProgramFiles(x86)}\Windows Kits\10\DesignTime\CommonConfiguration\Neutral\UAP\10.0.17763.0\UAP.props" | Should -Exist
    }
}

Describe "Windows 11 SDK" -Skip:(-not (Test-IsWin19)) {
    It "Verifies 22621 SDK is installed" {
        "${env:ProgramFiles(x86)}\Windows Kits\10\DesignTime\CommonConfiguration\Neutral\UAP\10.0.22621.0\UAP.props" | Should -Exist
    }
}

Describe "Windows 11 SDK" -Skip:(Test-IsWin19) {
    It "Verifies 26100 SDK is installed" {
        "${env:ProgramFiles(x86)}\Windows Kits\10\DesignTime\CommonConfiguration\Neutral\UAP\10.0.26100.0\UAP.props" | Should -Exist
    }
}

Describe "Dokany" -Skip:(Test-IsArm64) {
    It "Registers the Dokany filesystem driver" {
        $driver = Get-CimInstance Win32_SystemDriver -Filter "Name = 'dokan2'"
        $driver | Should -Not -BeNullOrEmpty
        $driver.PathName | Should -Match "dokan2.sys"
    }

    It "Installs a signed kernel driver" {
        $driverPath = Join-Path $env:SystemRoot "System32\drivers\dokan2.sys"
        $driverPath | Should -Exist
        (Get-AuthenticodeSignature $driverPath).Status | Should -Be "Valid"
    }

    It "Installs the x64 user-mode library" {
        $library = Get-ChildItem "${env:ProgramFiles}\Dokan" -Filter "dokan2.dll" -Recurse | Select-Object -First 1
        $library | Should -Not -BeNullOrEmpty
        $library.VersionInfo.FileVersion | Should -Match "^2\.3\.1"
    }
}

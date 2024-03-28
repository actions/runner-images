Describe "Wix" {
    BeforeAll {
      $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
      $installedApplications = Get-ItemProperty -Path $regKey
      $version = ($installedApplications | Where-Object { $_.BundleCachePath -imatch ".*\\WiX\d*\.exe$" } | Select-Object -First 1).DisplayName
    }

    It "Wix Toolset version from registry" {
      $version | Should -Not -BeNullOrEmpty
    }

    It "Wix variable exists" {
      $env:WIX | Should -Not -BeNullOrEmpty
    }

    It "Wix binaries folder exists" {
      Test-Path -Path $(Join-Path -Path $env:WIX -ChildPath "bin") | Should -Be $true
    }

    It "Wix binaries folder is in PATH" {
      $testPath = Join-Path -Path $env:WIX -ChildPath "bin"
      $env:PATH -split ";" | Should -Contain "$testPath"
    }
}

Describe "Wix" {
    BeforeAll {
      $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
      $installedApplications = Get-ItemProperty -Path $regKey
      $version = ($installedApplications | Where-Object { $_.BundleCachePath -imatch ".*\\WiX\d*\.exe$" } | Select-Object -First 1).DisplayName
    }

    It "Wix Toolset version from registry" {
      $version | Should -Not -BeNullOrEmpty
    }
}

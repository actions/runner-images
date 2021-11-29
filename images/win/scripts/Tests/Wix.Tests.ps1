Describe "Wix" {
    BeforeAll {
      $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
      $installedApplications = Get-ItemProperty -Path $regKey
      $version = ($installedApplications | Where-Object { $_.BundleCachePath -imatch ".*\\WiX\d*\.exe$" } | Select-Object -First 1).DisplayName
    }

    It "Wix Toolset version from registry" {
      $version | Should -Not -BeNullOrEmpty
    }

    It "Wix Toolset version from system" -Skip:(Test-IsWin22) {
      if (Test-IsWin19)
      {
        $exVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev16"
      }
      else
      {
        $exVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev15"
      }
      $exVersion | Should -Not -BeNullOrEmpty
    }
}

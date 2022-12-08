Describe "WDK" {
  It "WDK exists" {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    $WDKVersion = $installedApplications | Where-Object DisplayName -eq 'Windows Driver Kit' | Select-Object -First 1 -ExpandProperty DisplayVersion
    $WDKVersion | Should -Not -BeNullOrEmpty
  }

  It "Windows Driver Kit VSIX extension" {
    $version = Get-VSExtensionVersion -packageName "Microsoft.Windows.DriverKit"
    $version | Should -Not -BeNullOrEmpty
  }
}

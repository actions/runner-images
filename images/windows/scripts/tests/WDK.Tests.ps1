Describe "WDK" -Skip:(Test-IsWin25-X64) {
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

Describe "x64 Debugging Tools" -Skip:(-not (Test-IsWin11-Arm64)) {
  It "Verifies x64 dbghelp.dll is staged for Chromium builds" {
    "${env:ProgramFiles(x86)}\Windows Kits\10\Debuggers\x64\dbghelp.dll" | Should -Exist
  }
}

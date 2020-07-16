
Describe "WinAppDriver" {
    It "WinAppDriver directory exists" {
      $wad = "Windows Application Driver" 
      if (${env:ProgramFiles(x86)})
      {
        $wadPath = "${env:ProgramFiles(x86)}\$wad"
      }
      else
      {
       $wadPath = "${env:ProgramFiles}\$wad"
      }
      Test-Path -Path $wadPath | Should -Be $true
    }
    It "Developer Mode is enabled" {
      $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock";
      Get-ItemProperty -Path $path | Select-Object -ExpandProperty "AllowDevelopmentWithoutDevLicense" | Should -Be 1
    }
}

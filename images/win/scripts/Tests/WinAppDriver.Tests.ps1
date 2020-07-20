BeforeAll {
    $wad = "Windows Application Driver"
    if (${env:ProgramFiles(x86)})
    {
      $wadPath = Join-Path ${env:ProgramFiles(x86)} $wad
    }
    else
    {
     $wadPath = Join-Path ${env:ProgramFiles} $wad
    }
}
Describe "WinAppDriver" {
    It "WinAppDriver directory exists" {
      $wadPath | Should -Exist
    }
    It "Developer Mode is enabled" {
      $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock";
      Get-ItemProperty -Path $path | Select-Object -ExpandProperty "AllowDevelopmentWithoutDevLicense" | Should -Be 1
    }
}

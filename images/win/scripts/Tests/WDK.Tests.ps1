Describe "WDK" {
    BeforeAll {
      $Global:WDKVersion = (Get-CimInstance -ClassName Win32_Product -Filter "Name = 'Windows Driver Kit'").Version
    }

    It "WDK exists" {
      $Global:WDKVersion| Should -Not -BeNullOrEmpty
    }

    It "WDK version from system" {
      $version = Get-VSExtensionVersion -packageName "Microsoft.Windows.DriverKit"
      $version | Should -Not -BeNullOrEmpty
    }
}

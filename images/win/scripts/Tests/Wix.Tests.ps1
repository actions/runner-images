Import-Module -Name ImageHelpers -Force



Describe "Wix" {
    BeforeAll {         
      $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
      $installedApplications = Get-ItemProperty -Path $regKey
      $Global:Version = ($installedApplications | Where-Object { $_.DisplayName -and $_.DisplayName.toLower().Contains("wix") } | Select-Object -First 1).DisplayVersion
    }
    
    It "Wix Toolset version from registry" {
      "$Global:Version" | Should -Not -Be ""
    }

    It "Wix Toolset version from system" {
      if (Test-IsWin19)
      {
        $exVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev16"
      }
      else
      {
        $exVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev15"
      }
      "$exVersion" | Should -Not -Be ""
    }
}

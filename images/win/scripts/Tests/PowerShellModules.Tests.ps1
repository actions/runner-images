# Validate the installation
Describe 'SQLPowerShellTools' {
  #BeforeAll {
  #  $env:PSModulePath = Get-SystemVariable "PSModulePath"
  #}

  It 'The SQLPS module exists' {
     $modules = Get-Module -Name SQLPS -ListAvailable
     $modules.Count | Should -Be 1
  }

  It 'The SQLServer module exists' {
     $modules = Get-Module -Name SQLServer -ListAvailable
     $modules.Count | Should -Be 1
  }
}

Describe 'WindowsUpdates' {
  #BeforeAll {
  #  $env:PSModulePath = Get-SystemVariable "PSModulePath"
  #}

  It 'The PSWindowsUpdate module exists' {
     $modules = Get-Module -Name PSWindowsUpdate -ListAvailable
     $modules.Count | Should -Be 1
  }
}

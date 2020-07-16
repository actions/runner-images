
# Validate the installation
Describe 'WindowsUpdates PS module' {
  BeforeAll {
    $env:PSModulePath = Get-SystemVariable "PSModulePath"
  }
  It 'The PSWindowsUpdate module exists' {
     $modules = Get-Module -Name PSWindowsUpdate -ListAvailable
     $modules.Count | Should -Be 1
  }
}

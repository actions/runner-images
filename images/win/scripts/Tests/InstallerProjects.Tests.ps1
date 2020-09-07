Import-Module -Name VsSetup -Force
Describe "InstallProjects" {
    It "InstallProjects exists" {
        $InstallProjects = (Get-VSSetupInstance | Select-VsSetupInstance -Product *).Packages | Where-Object {$_.id -eq 'VSInstallerProjects' }
        $InstallProjects | Should -Not -BeNullOrEmpty
    }
}
Describe "SSDTExtensions" {
    It "Extension SSDT" {
        $version = Get-VSExtensionVersion -packageName "SSDT"
        $version | Should -Not -BeNullOrEmpty
    }
}

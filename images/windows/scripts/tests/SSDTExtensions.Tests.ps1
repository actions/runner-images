Describe "SSDTExtensions" {
#These extensions don't have any proper name in the state.packages.json file, only id is available, which can be found on extension marketplace download page
    It "Extension SSDT" {
        $version = Get-VSExtensionVersion -packageName "SSDT"
        $version | Should -Not -BeNullOrEmpty
    }
}

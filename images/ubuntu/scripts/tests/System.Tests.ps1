Describe "Disk free space" {
    It "Image has more than 15GB free space" {
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 15GB
    }
}

Describe "Disk free space" {
    It "Image has more than 31GB free space" {
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 31GB
    }
}

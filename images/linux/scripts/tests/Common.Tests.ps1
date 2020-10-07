Describe "PATH check" {
    It "PATH is not quoted" {
        $PATH | Should -Not -Be '"*"'
    }
}

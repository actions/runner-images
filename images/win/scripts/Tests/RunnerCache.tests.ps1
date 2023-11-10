Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "C:\ProgramData\runner" {
            (Get-ChildItem -Path "C:\ProgramData\runner\*.zip" -Recurse).Count | Should -BeGreaterThan 0
        }
    }
}

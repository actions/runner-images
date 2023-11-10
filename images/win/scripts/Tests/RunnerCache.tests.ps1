Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "C:\ProgramData\runner" {
            (Get-ChildItem -Path "/opt/runner-cache/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }
}

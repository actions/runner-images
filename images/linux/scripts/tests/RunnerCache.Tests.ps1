Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "/opt/runner-cache not empty" {
            (Get-ChildItem -Path "/opt/runner-cache/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }
}

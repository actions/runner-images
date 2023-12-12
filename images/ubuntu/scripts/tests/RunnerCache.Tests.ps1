Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "<Path> not empty" -TestCases @{ Path = "/opt/runner-cache" } {
            (Get-ChildItem -Path "$Path/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }
}

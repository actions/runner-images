Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "<RunnerCachePath> not empty" -TestCases @{ RunnerCachePath = "/opt/runner-cache" } {
            (Get-ChildItem -Path "$RunnerCachePath/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }
}

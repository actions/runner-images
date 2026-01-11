Describe "RunnerCache" {
    Context "runner cache directory not empty" {
        It "<RunnerCachePath> not empty" -TestCases @{ RunnerCachePath = "/opt/runner-cache" } {
            (Get-ChildItem -Path "$RunnerCachePath/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }

    Context "runner pre-extracted" {
        It "/opt/actions-runner/run.sh exists" {
            Test-Path "/opt/actions-runner/run.sh" | Should -Be $true
        }
        It "/opt/actions-runner/config.sh exists" {
            Test-Path "/opt/actions-runner/config.sh" | Should -Be $true
        }
    }
}

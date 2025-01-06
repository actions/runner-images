Describe "ActionArchiveCache" {
    BeforeDiscovery {
        $actionArchiveCachePath = "/opt/actionarchivecache"
        $tarballTestCases = Get-ChildItem -Path "$actionArchiveCachePath/*.tar.gz" -Recurse | ForEach-Object { @{ ActionTarball = $_.FullName } }
    }

    Context "Action archive cache directory not empty" {
        It "<ActionArchiveCachepath> not empty" -TestCases @{ ActionArchiveCachepath = $actionArchiveCachePath } {
            (Get-ChildItem -Path "$ActionArchiveCachepath/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }

    Context "Action tarball not empty" {
        It "<ActionTarball>" -TestCases $tarballTestCases {
            (Get-Item "$ActionTarball").Length | Should -BeGreaterThan 0
        }
    }
}

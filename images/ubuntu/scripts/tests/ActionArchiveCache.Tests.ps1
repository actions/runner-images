Describe "ActionArchiveCache" {
    $actionArchiveCachePath = "/opt/actionarchivecache"

    Context "Action archive cache directory not empty" {
        It "$actionArchiveCachePath not empty" {
            (Get-ChildItem -Path "$actionArchiveCachePath/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }

    Context "Action tarball not empty" {
        $testCases = Get-ChildItem -Path "$actionArchiveCachePath/*.tar.gz" -Recurse | ForEach-Object { @{ ActionTarball = $_.FullName } }

        It "<ActionTarball>" -TestCases $testCases {
            (Get-Item "$ActionTarball").Length | Should -BeGreaterThan 0
        }
    }
}

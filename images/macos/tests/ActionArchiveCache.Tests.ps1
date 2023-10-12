Describe "ActionArchiveCache" {
    Context "Action archive cache directory not empty" {
        It "$HOME/actionarchivecache not empty" {
            (Get-ChildItem -Path "$env:HOME/actionarchivecache/*.tar.gz" -Recurse).Count | Should -BeGreaterThan 0
        }
    }

    Context "Action tarball not empty" {
        $testCases = Get-ChildItem -Path "$env:HOME/actionarchivecache/*.tar.gz" -Recurse | ForEach-Object { @{ ActionTarball = $_.FullName } }
        It "<ActionTarball>" -TestCases $testCases {
            param ([string] $ActionTarball)
            (Get-Item "$ActionTarball").Length | Should -BeGreaterThan 0
        }
    }
}

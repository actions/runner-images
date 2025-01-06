Describe "ActionArchiveCache" {
    Context "Action archive cache directory not empty" {
        It "C:\actionarchivecache not empty" {
            (Get-ChildItem -Path "C:\actionarchivecache\*.zip" -Recurse).Count | Should -BeGreaterThan 0
        }
    }

    Context "Action zipball not empty" {
        $testCases = Get-ChildItem -Path "C:\actionarchivecache\*.zip" -Recurse | ForEach-Object { @{ ActionZipball = $_.FullName } }
        It "<ActionZipball>" -TestCases $testCases {
            param ([string] $ActionZipball)
            (Get-Item "$ActionZipball").Length | Should -BeGreaterThan 0
        }
    }
}

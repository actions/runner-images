Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            "$($_) --version" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Kind" {
    It "Kind" {
        "kind version" | Should -ReturnZeroExitCode
    }
}

Describe "7-Zip" {
    It "7z" {
        #throw "fake error"
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "Fake_test" {
    It "Fake" {
        $true | Should -BeFalse
    }
}

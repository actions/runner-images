Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            "$($_) --version" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Kind" {
    It "kind2" {
        throw "erre"
        $true | Should -BeTrue
    }
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

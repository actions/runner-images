Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            "$($_) --vesion" | Should -ReturnZeroExitCode
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

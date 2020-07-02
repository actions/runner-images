Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            "$($_) --veion" | Should -ReturnZeroExitCode
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
        "7z" | Should -ReturnZeroExitCode
    }
}

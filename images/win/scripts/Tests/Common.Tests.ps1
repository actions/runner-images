Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            Validate-ZeroExitCode "$($_) --version" | Should -Be 0
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
        "7z --version" | Should -ReturnZeroExitCode
    }
}

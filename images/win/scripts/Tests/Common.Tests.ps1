Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            Validate-ZeroExitCode "$($_) --version" | Should -Be 0
        }
    }
}

Describe "Kind" {
    It "Kind" {
        Validate-ZeroExitCode "kind version" | Should -Be 0
    }
}

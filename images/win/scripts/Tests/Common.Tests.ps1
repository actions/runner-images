Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            Validate-ZeroExitCode "$($_) --version" | Should -Be 0
        }
    }
}

Describe "Kind" {
    It "Kind" {
        Write-Host $env:PATH
        "kind version" | Should -ReturnZeroExitCode
    }
}

Describe "MongoDB" {
    @("mongo", "mongod") | ForEach-Object {
        It "$_" {
            "$($_) --version" | Should -ReturnZeroExitCode
        }
    }
}

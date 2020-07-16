
Describe "Svn" {
    It "svn exists" {
        "svn --version --quiet" | Should -ReturnZeroExitCode
    }
}

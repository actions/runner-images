
Describe "Zstd" {
    It "zstd exists" {
        "zstd -V" | Should -ReturnZeroExitCode
    }
}

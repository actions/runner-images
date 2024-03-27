Describe "Wix" {
    It "Wix Toolset binaries have been installed and are available in env:Path" {
        "candle.exe -?" | Should -ReturnZeroExitCode
    }
}

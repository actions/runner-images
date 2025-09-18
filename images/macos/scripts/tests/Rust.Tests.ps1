Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Rust" {
    Context "Rust" {
        It "Rustup is installed" {
            "rustup --version" | Should -ReturnZeroExitCode
        }

        It "Rustc is installed" {
            "rustc --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Cargo" {
        It "Cargo is installed" {
            "cargo --version" | Should -ReturnZeroExitCode
        }
    }
}

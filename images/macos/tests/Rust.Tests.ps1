Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Rust" -Skip:($os.IsHighSierra) {

    Context "Rust is installed" {
        It "Rustup is installed" {
            "rustup --version" | Should -ReturnZeroExitCode
        }

        It "Rustc is installed" {
            "rustc --version" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Cargo" {
    Context "Cargo is installed" {
        It "Cargo is installed" {
            "cargo --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Cargo dependencies" {
        It "bindgen" {
            "bindgen --version" | Should -ReturnZeroExitCode
        }

        It "cbindgen" {
            "cbindgen --version" | Should -ReturnZeroExitCode
        }

        It "Cargo audit" {
            "cargo audit --version" | Should -ReturnZeroExitCode
        }

        It "Cargo outdated" {
            "cargo outdated --version" | Should -ReturnZeroExitCode
        }
    }
}
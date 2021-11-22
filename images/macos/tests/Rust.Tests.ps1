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
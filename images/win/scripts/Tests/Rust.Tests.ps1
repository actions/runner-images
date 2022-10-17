Describe "Rust" {
    BeforeAll {
        $env:RUSTUP_HOME = "C:\Users\Default\.rustup"
        $env:CARGO_HOME = "C:\Users\Default\.cargo"
        $env:Path += ";$env:CARGO_HOME\bin"
    }

    $rustTools = @(
        @{ToolName = "rustup"; binPath = "$env:CARGO_HOME\bin\rustup.exe"}
        @{ToolName = "rustc"; binPath = "$env:CARGO_HOME\bin\rustc.exe"}
        @{ToolName = "bindgen.exe"; binPath = "$env:CARGO_HOME\bin\bindgen.exe"}
        @{ToolName = "cbindgen.exe"; binPath = "$env:CARGO_HOME\bin\cbindgen.exe"}
        @{ToolName = "cargo"; binPath = "$env:CARGO_HOME\bin\cargo.exe"}
        @{ToolName = "cargo audit"; binPath = "$env:CARGO_HOME\bin\cargo-audit.exe"}
        @{ToolName = "cargo outdated"; binPath = "$env:CARGO_HOME\bin\cargo-outdated.exe"}
    )

    $rustEnvNotExists = @(
        @{envVar = "RUSTUP_HOME"}
        @{envVar = "CARGO_HOME"}
    )

    It "C:\Users\Default\.rustup and C:\Users\Default\.cargo folders exist" {
        "C:\Users\Default\.rustup", "C:\Users\Default\.cargo" | Should -Exist
    }

    It "<envVar> environment variable does not exist" -TestCases $rustEnvNotExists {
        [Environment]::GetEnvironmentVariables("Machine").ContainsKey($envVar) | Should -BeFalse
    }

    It "<ToolName> is installed to the '<binPath>' folder" -TestCases $rustTools {
        "$ToolName --version" | Should -ReturnZeroExitCode
        $binPath | Should -Exist
    }
}

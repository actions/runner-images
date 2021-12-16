Describe "Rust" {
    BeforeAll {
        $env:RUSTUP_HOME = "C:\Users\Default\.rustup"
        $env:CARGO_HOME = "C:\Users\Default\.cargo"
        $env:Path += ";$env:CARGO_HOME\bin"
    }

    $rustTools = @(
        @{ToolName = "rustup"; binPath = "C:\Users\Default\.cargo\bin\rustup.exe"}
        @{ToolName = "rustc"; binPath = "C:\Users\Default\.cargo\bin\rustc.exe"}
        @{ToolName = "cargo"; binPath = "C:\Users\Default\.cargo\bin\cargo.exe"}
        @{ToolName = "cargo audit"; binPath = "C:\Users\Default\.cargo\bin\cargo-audit.exe"}
        @{ToolName = "cargo outdated"; binPath = "C:\Users\Default\.cargo\bin\cargo-outdated.exe"}
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

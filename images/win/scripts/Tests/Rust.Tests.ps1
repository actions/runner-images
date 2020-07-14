Describe "Rust" {
    Push-Location -Path $env:UserProfile
    if ( -not ((Test-Path -Path ".rustup") -and (Test-Path -Path ".cargo")))
    {
        $null = New-Item -Name ".rustup" -Value "C:\Rust\.rustup" -ItemType Junction
        $null = New-Item -Name ".cargo" -Value "C:\Rust\.cargo" -ItemType Junction
    }
    Pop-Location

    $rustTools = @(
        @{command = "rustup"; binPath = "C:\Rust\.cargo\bin\rustup.exe"}
        @{command = "rustc"; binPath = "C:\Rust\.cargo\bin\rustc.exe"}
        @{command = "cargo"; binPath = "C:\Rust\.cargo\bin\cargo.exe"}
        @{command = "cargo audit"; binPath = "C:\Rust\.cargo\bin\cargo-audit.exe"}
        @{command = "cargo outdated"; binPath = "C:\Rust\.cargo\bin\cargo-outdated.exe"}
    )

    $rustEnvNotExists = @(
        @{envVar = "RUSTUP_HOME"}
        @{envVar = "CARGO_HOME"}
    )

    It "C:\Rust\.rustup and C:\Rust\.cargo folders exist" {
        "C:\Rust\.rustup", "C:\Rust\.cargo" | Should -Exist
    }

    It "<envVar> environment variable does not exist" -TestCases $rustEnvNotExists {
        [Environment]::GetEnvironmentVariables("Machine").ContainsKey($envVar) | Should -BeFalse
    }

    It "<command> is installed to the '<binPath>' folder" -TestCases $rustTools {
        "$command --version" | Should -ReturnZeroExitCode
        $binPath | Should -Exist
    }
}
################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
################################################################################

Import-Module -Name ImageHelpers

# Rust Env
$env:RUSTUP_HOME="C:\Rust\.rustup"
$env:CARGO_HOME="C:\Rust\.cargo"

# Download the latest rustup-init.exe for Windows x64
# See https://rustup.rs/#
Invoke-WebRequest -UseBasicParsing -Uri "https://win.rustup.rs/x86_64" -OutFile rustup-init.exe

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
.\rustup-init.exe -y --default-toolchain=stable --profile=minimal

# Delete rustup-init.exe when it's no longer needed
Remove-Item -Path .\rustup-init.exe

# Add Rust binaries to the path
Add-MachinePathItem "$env:CARGO_HOME\bin"
$env:Path = Get-MachinePath

# Install common tools
rustup component add rustfmt clippy
cargo install bindgen cbindgen

# Run script at startup for all users
$cmdRustSymScript = @"
@echo off

if exist $env:CARGO_HOME (
    if not exist %USERPROFILE%\.cargo (
        mklink /J %USERPROFILE%\.cargo $env:CARGO_HOME
    )
)

if exist $env:RUSTUP_HOME (
    if not exist %USERPROFILE%\.rustup (
        mklink /J %USERPROFILE%\.rustup $env:RUSTUP_HOME
    )
)
"@

$cmdPath = "C:\Rust\rustsym.bat"
$cmdRustSymScript | Out-File -Encoding ascii -FilePath $cmdPath

# Update Run key to run a script at logon
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "RUSTSYM" -Value $cmdPath

################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
################################################################################

Import-Module -Name ImageHelpers

# Rust Env
$env:RUSTUP_HOME="C:\users\default\.rustup"
$env:CARGO_HOME="C:\users\default\.cargo"

# Download the latest rustup-init.exe for Windows x64
# See https://rustup.rs/#
Invoke-WebRequest -UseBasicParsing -Uri "https://win.rustup.rs/x86_64" -OutFile rustup-init.exe

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
.\rustup-init.exe -y --default-toolchain=stable --profile=minimal

# Delete rustup-init.exe when it's no longer needed
Remove-Item -Path .\rustup-init.exe

# Install common tools
rustup component add rustfmt clippy
cargo install bindgen cbindgen

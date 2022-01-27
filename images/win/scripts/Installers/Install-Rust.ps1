################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
################################################################################

# Rust Env
$env:RUSTUP_HOME = "C:\Users\Default\.rustup"
$env:CARGO_HOME = "C:\Users\Default\.cargo"

# Download the latest rustup-init.exe for Windows x64
# See https://rustup.rs/#
$rustupPath = Start-DownloadWithRetry -Url "https://win.rustup.rs/x86_64" -Name "rustup-init.exe"

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
& $rustupPath -y --default-toolchain=stable --profile=minimal

# Add %USERPROFILE%\.cargo\bin to USER PATH
Add-DefaultPathItem "%USERPROFILE%\.cargo\bin"
# Add Rust binaries to the path
$env:Path += ";$env:CARGO_HOME\bin"

# Install common tools
rustup component add rustfmt clippy
cargo install --locked bindgen cbindgen cargo-audit cargo-outdated

# Cleanup Cargo crates cache
Remove-Item "${env:CARGO_HOME}\registry\*" -Recurse -Force

Invoke-PesterTests -TestFile "Rust"

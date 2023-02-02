################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
################################################################################

# Rust Env
$env:RUSTUP_HOME = "C:\Users\Default\.rustup"
$env:CARGO_HOME = "C:\Users\Default\.cargo"

# Download the latest rustup-init.exe for Windows x64
# See https://rustup.rs/#
$rustupPath = Start-DownloadWithRetry -Url "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe" -Name "rustup-init.exe"

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
& $rustupPath -y --default-toolchain=stable --profile=minimal

# Add %USERPROFILE%\.cargo\bin to USER PATH
Add-DefaultPathItem "%USERPROFILE%\.cargo\bin"
# Add Rust binaries to the path
$env:Path += ";$env:CARGO_HOME\bin"

# Add i686 target for building 32-bit binaries
rustup target add i686-pc-windows-msvc

# Add target for building mingw-w64 binaries
rustup target add x86_64-pc-windows-gnu

# Install common tools
rustup component add rustfmt clippy
cargo install --locked bindgen-cli cbindgen cargo-audit cargo-outdated

# Cleanup Cargo crates cache
Remove-Item "${env:CARGO_HOME}\registry\*" -Recurse -Force

Invoke-PesterTests -TestFile "Rust"

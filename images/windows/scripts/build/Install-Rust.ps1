################################################################################
##  File:  Install-Rust.ps1
##  Desc:  Install Rust for Windows
##  Supply chain security: checksum validation for bootstrap, managed by rustup for workloads
################################################################################

if (Test-IsArm64) {
    $rustArch = "aarch64"
} else {
    $rustArch = "x86_64"
}

# Rust Env
$env:RUSTUP_HOME = "C:\Users\Default\.rustup"
$env:CARGO_HOME = "C:\Users\Default\.cargo"

# Download the latest rustup-init.exe for Windows
# See https://rustup.rs/#
$rustupPath = Invoke-DownloadWithRetry "https://static.rust-lang.org/rustup/dist/${rustArch}-pc-windows-msvc/rustup-init.exe"

#region Supply chain security
$distributorFileHash = (Invoke-RestMethod -Uri "https://static.rust-lang.org/rustup/dist/${rustArch}-pc-windows-msvc/rustup-init.exe.sha256").Trim()
Test-FileChecksum $rustupPath -ExpectedSHA256Sum $distributorFileHash
#endregion

# Install Rust by running rustup-init.exe (disabling the confirmation prompt with -y)
& $rustupPath -y --default-toolchain=stable --profile=minimal
if ($LASTEXITCODE -ne 0) {
    throw "Rust installation failed with exit code $LASTEXITCODE"
}

# Add %USERPROFILE%\.cargo\bin to USER PATH
Add-DefaultPathItem "%USERPROFILE%\.cargo\bin"
# Add Rust binaries to the path
$env:Path += ";$env:CARGO_HOME\bin"

if (Test-IsArm64) {
    rustup target add aarch64-pc-windows-msvc
} else {
    # Add i686 target for building 32-bit binaries
    rustup target add i686-pc-windows-msvc

    # Add target for building mingw-w64 binaries
    rustup target add x86_64-pc-windows-gnu
}

# Install common tools
rustup component add rustfmt clippy
if ($LASTEXITCODE -ne 0) {
    throw "Rust component installation failed with exit code $LASTEXITCODE"
}

if ((Test-IsWin22-X64) -or (Test-IsWin11-Arm64)) {
    cargo install --locked bindgen-cli cbindgen cargo-audit cargo-outdated
    if ($LASTEXITCODE -ne 0) {
        throw "Rust tools installation failed with exit code $LASTEXITCODE"
    }
    # Cleanup Cargo crates cache
    Remove-Item "${env:CARGO_HOME}\registry\*" -Recurse -Force
}

Invoke-PesterTests -TestFile "Rust"

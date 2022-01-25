function Initialize-RustEnvironment {
    $env:PATH = "/etc/skel/.cargo/bin:/etc/skel/.rustup/bin:$($env:PATH)"
    $env:RUSTUP_HOME = "/etc/skel/.rustup"
    $env:CARGO_HOME = "/etc/skel/.cargo"
}

function Get-RustVersion {
    Initialize-RustEnvironment
    $rustVersion = $(rustc --version) | Take-OutputPart -Part 1
    return "Rust $rustVersion"
}

function Get-BindgenVersion {
    $bindgenVersion = $(bindgen --version) | Take-OutputPart -Part 1
    return "Bindgen $bindgenVersion"
}

function Get-CargoVersion {
    $cargoVersion = $(cargo --version) | Take-OutputPart -Part 1
    return "Cargo $cargoVersion"
}

function Get-CargoAuditVersion {
    $cargoAuditVersion = $(cargo audit --version) | Take-OutputPart -Part 1
    return "Cargo audit $cargoAuditVersion"
}

function Get-CargoOutdatedVersion {
    $cargoOutdatedVersion = $(cargo outdated --version) | Take-OutputPart -Part 1 -Delimiter "v"
    return "Cargo outdated $cargoOutdatedVersion"
}

function Get-CargoClippyVersion {
    $cargoClippyVersion = $(cargo-clippy --version) | Take-OutputPart -Part 1
    return "Cargo clippy $cargoClippyVersion"
}

function Get-CbindgenVersion {
    $cbindgenVersion = $(cbindgen --version) | Take-OutputPart -Part 1
    return "Cbindgen $cbindgenVersion"
}

function Get-RustupVersion {
    $rustupVersion = $(rustup --version) | Take-OutputPart -Part 1
    return "Rustup $rustupVersion"
}

function Get-RustdocVersion {
    $rustdocVersion = $(rustdoc --version) | Take-OutputPart -Part 1
    return "Rustdoc $rustdocVersion"
}

function Get-RustfmtVersion {
    $rustfmtVersion = $(rustfmt --version) | Take-OutputPart -Part 1 | Take-OutputPart -Part 0 -Delimiter "-"
    return "Rustfmt $rustfmtVersion"
}

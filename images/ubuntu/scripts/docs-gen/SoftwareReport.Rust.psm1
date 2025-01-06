function Initialize-RustEnvironment {
    $env:PATH = "/etc/skel/.cargo/bin:/etc/skel/.rustup/bin:$($env:PATH)"
    $env:RUSTUP_HOME = "/etc/skel/.rustup"
    $env:CARGO_HOME = "/etc/skel/.cargo"
}

function Get-RustVersion {
    $rustVersion = $(rustc --version) | Get-StringPart -Part 1
    return $rustVersion
}

function Get-BindgenVersion {
    $bindgenVersion = $(bindgen --version) | Get-StringPart -Part 1
    return $bindgenVersion
}

function Get-CargoVersion {
    $cargoVersion = $(cargo --version) | Get-StringPart -Part 1
    return $cargoVersion
}

function Get-CargoAuditVersion {
    $cargoAuditVersion = $(cargo-audit --version) | Get-StringPart -Part 1
    return $cargoAuditVersion
}

function Get-CargoOutdatedVersion {
    $cargoOutdatedVersion = cargo outdated --version | Get-StringPart -Part 1
    return $cargoOutdatedVersion
}

function Get-CargoClippyVersion {
    $cargoClippyVersion = $(cargo-clippy --version) | Get-StringPart -Part 1
    return $cargoClippyVersion
}

function Get-CbindgenVersion {
    $cbindgenVersion = $(cbindgen --version) | Get-StringPart -Part 1
    return $cbindgenVersion
}

function Get-RustupVersion {
    $rustupVersion = $(rustup --version) | Get-StringPart -Part 1
    return $rustupVersion
}

function Get-RustdocVersion {
    $rustdocVersion = $(rustdoc --version) | Get-StringPart -Part 1
    return $rustdocVersion
}

function Get-RustfmtVersion {
    $rustfmtVersion = $(rustfmt --version) | Get-StringPart -Part 1 | Get-StringPart -Part 0 -Delimiter "-"
    return $rustfmtVersion
}

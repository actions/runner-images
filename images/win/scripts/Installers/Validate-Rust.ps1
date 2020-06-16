################################################################################
##  File:  Validate-Rust.ps1
##  Desc:  Verify that Rust is on the path and output version information.
################################################################################

if (Get-Command -Name 'rustc')
{
    Push-Location -Path $env:UserProfile
    New-Item -Name ".rustup" -Value "C:\Rust\.rustup" -ItemType Junction
    New-Item -Name ".cargo" -Value "C:\Rust\.cargo" -ItemType Junction
    $RustcVersion = rustc --version
    Write-Host "$RustcVersion is on the path"
    Pop-Location
}
else
{
    Write-Host "rustc is not on the path"
    exit 1
}

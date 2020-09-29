# Create Rust junction points to cargo and rustup folder
$cargoTarget = "$env:USERPROFILE\.cargo"
if (-not (Test-Path $cargoTarget))
{
    New-Item -ItemType Junction -Path $cargoTarget -Target "C:\Rust\.cargo"

    if (Test-Path $cargoTarget)
    {
        Write-Host "Junction created for $cargoTarget <<===>> C:\Rust\.cargo"
    }
    else
    {
        Write-Host "Junction was not created for $cargoTarget"
    }
}

$rustupTarget = "$env:USERPROFILE\.rustup"
if (-not (Test-Path $rustupTarget))
{
    New-Item -ItemType Junction -Path $rustupTarget -Target "C:\Rust\.rustup"

    if (Test-Path $rustupTarget)
    {
        Write-Host "Junction created for $rustupTarget <<===>> C:\Rust\.rustup"
    }
    else
    {
        Write-Host "Junction was not created for $rustupTarget"
    }
}
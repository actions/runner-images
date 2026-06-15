################################################################################
##  File:  Install-LLVM.ps1
##  Desc:  Install the stable version of llvm and clang compilers
################################################################################

$llvmVersion = (Get-ToolsetContent).llvm.version

function Write-RecentChocoLog {
    param(
        [string] $LogPath,
        [int] $Tail = 200
    )

    if (-not (Test-Path $LogPath)) {
        Write-Host "Chocolatey log was not found at: $LogPath"
        return
    }

    Write-Host "--- Last $Tail lines of $LogPath ---"
    Get-Content -Path $LogPath -Tail $Tail
    Write-Host "--- End of Chocolatey log tail ---"
}

if (Test-IsArm64) {
    $installDir = "C:\Program Files\LLVM"

    Write-Host "Resolve LLVM $llvmVersion ARM64 download URL"
    $downloadUrl = Resolve-GithubReleaseAssetUrl `
        -Repository "llvm/llvm-project" `
        -Version $llvmVersion `
        -UrlMatchPattern "clang*llvm-*-aarch64-pc-windows-msvc.tar.xz"

    Write-Host "Download LLVM $llvmVersion ARM64 archive"
    $archivePath = Invoke-DownloadWithRetry $downloadUrl

    Write-Host "Extract LLVM archive"
    $tarPath = $archivePath -replace '\.xz$'
    Expand-7ZipArchive -Path $archivePath -DestinationPath (Split-Path $archivePath)
    Expand-7ZipArchive -Path $tarPath -DestinationPath $env:TEMP_DIR

    Write-Host "Install LLVM to $installDir"
    $extractedDir = Get-ChildItem -Path $env:TEMP_DIR -Directory -Filter "clang+llvm-*" | Select-Object -First 1
    Move-Item -Path $extractedDir.FullName -Destination $installDir -Force

    Add-MachinePathItem (Join-Path $installDir "bin")
    Update-Environment
} else {
    $chocoLogPath = "C:\ProgramData\chocolatey\logs\chocolatey.log"
    $latestChocoVersion = Resolve-ChocoPackageVersion -PackageName "llvm" -TargetVersion $llvmVersion

    if (-not $latestChocoVersion) {
        Write-RecentChocoLog -LogPath $chocoLogPath
        throw "Unable to resolve Chocolatey version for llvm target version '$llvmVersion'."
    }

    Write-Host "Resolved llvm Chocolatey version: $latestChocoVersion"
    Write-Host "Chocolatey CLI version: $(choco --version)"
    Write-Host "Chocolatey source list:"
    choco source list

    $chocoArgs = @("install", "llvm", "--version", $latestChocoVersion, "-y", "--no-progress", "--require-checksums")
    Write-Host "Running: choco $($chocoArgs -join ' ')"

    & choco @chocoArgs
    $chocoExitCode = $LASTEXITCODE
    Write-Host "Chocolatey exit code: $chocoExitCode"

    if ($chocoExitCode -ne 0) {
        Write-RecentChocoLog -LogPath $chocoLogPath
        throw "Chocolatey failed to install llvm version '$latestChocoVersion'. Exit code: $chocoExitCode"
    }

    $installedPackage = choco list --localonly llvm --exact --all --limitoutput
    if (-not $installedPackage) {
        Write-RecentChocoLog -LogPath $chocoLogPath
        throw "llvm was not found in local Chocolatey package list after installation."
    }

    Write-Host "Package installed: $installedPackage"
}

Invoke-PesterTests -TestFile "LLVM"

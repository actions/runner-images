################################################################################
##  File:  Install-LLVM.ps1
##  Desc:  Install the stable version of llvm and clang compilers
################################################################################

$llvmVersion = (Get-ToolsetContent).llvm.version

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
    $latestChocoVersion = Resolve-ChocoPackageVersion -PackageName "llvm" -TargetVersion $llvmVersion
    Install-ChocoPackage llvm -ArgumentList '--version', $latestChocoVersion
}

Invoke-PesterTests -TestFile "LLVM"

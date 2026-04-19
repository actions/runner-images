################################################################################
##  File:  Install-CMake.ps1
##  Desc:  Install CMake (ARM64 only; x64 is installed via Choco)
##  Supply chain security: CMake - checksum validation
################################################################################

# Install CMake
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "Kitware/CMake" `
    -Version "latest" `
    -UrlMatchPattern "cmake-*-windows-arm64.msi"

#region Supply chain security - CMake
$packageName = Split-Path $downloadUrl -Leaf
$checksumsUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "Kitware/CMake" `
    -Version "latest" `
    -UrlMatchPattern "cmake-*-SHA-256.txt"
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url $checksumsUrl `
    -FileName $packageName
#endregion

Install-Binary `
    -Url $downloadUrl `
    -ExtraInstallArgs @("ADD_CMAKE_TO_PATH=System") `
    -ExpectedSHA256Sum $externalHash

Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "CMake"

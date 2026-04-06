################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
##  Supply chain security: GitHub CLI - checksum validation
################################################################################

if (Test-IsArm64) {
    $ghArch = "arm64"
} else {
    $ghArch = "amd64"
}

Write-Host "Get the latest gh version..."
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "cli/cli" `
    -Version "latest" `
    -UrlMatchPattern "gh_*_windows_$ghArch.msi"

$checksumsUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "cli/cli" `
    -Version "latest" `
    -UrlMatchPattern "gh_*_checksums.txt"
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url $checksumsUrl `
    -FileName (Split-Path $downloadUrl -Leaf)

Install-Binary `
    -Url $downloadUrl `
    -ExpectedSHA256Sum $externalHash

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"

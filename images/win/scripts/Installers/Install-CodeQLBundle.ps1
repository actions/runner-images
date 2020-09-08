################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

Import-Module -Name ImageHelpers

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
$CodeQLBundleName = (Invoke-WebRequest "https://raw.githubusercontent.com/github/codeql-action/main/src/defaults.json" | ConvertFrom-Json).bundleVersion
# Convert the bundle name to a version number (0.0.0-YYYYMMDD).
$CodeQLBundleVersion = "0.0.0-" + $CodeQLBundleName.split("-")[-1]

$ExtractionDirectory = "$Env:AGENT_TOOLSDIRECTORY/CodeQL/$CodeQLBundleVersion/x64"
New-Item -Path $ExtractionDirectory -ItemType Directory -Force | Out-Null

Write-Host "Downloading CodeQL bundle $CodeQLBundleVersion..."
$CodeQLBundlePath = Start-DownloadWithRetry -Url "https://github.com/github/codeql-action/releases/download/$CodeQLBundleName/codeql-bundle.tar.gz" -Name "codeql-bundle.tar.gz"
$DownloadDirectoryPath = (Get-Item $CodeQLBundlePath).Directory.FullName
Extract-7Zip -Path $CodeQLBundlePath -DestinationPath $DownloadDirectoryPath
Remove-Item -Path $CodeQLBundlePath
$UnGzipedCodeQLBundlePath = (Join-Path $DownloadDirectoryPath "codeql-bundle.tar")
Extract-7Zip -Path $UnGzipedCodeQLBundlePath -DestinationPath $ExtractionDirectory
Remove-Item -Path $UnGzipedCodeQLBundlePath

# Test that the tool has been extracted successfully.
& (Join-Path $ExtractionDirectory "codeql" "codeql.exe") version

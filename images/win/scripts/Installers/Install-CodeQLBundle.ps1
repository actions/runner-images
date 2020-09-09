################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
$CodeQLBundleName = (Invoke-RestMethod "https://raw.githubusercontent.com/github/codeql-action/main/src/defaults.json").bundleVersion
# Convert the bundle name to a version number (0.0.0-YYYYMMDD).
$CodeQLBundleVersion = "0.0.0-" + $CodeQLBundleName.split("-")[-1]

$ExtractionDirectory = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath $CodeQLBundleVersion | Join-Path -ChildPath "x64"
New-Item -Path $ExtractionDirectory -ItemType Directory -Force | Out-Null

Write-Host "Downloading CodeQL bundle $CodeQLBundleVersion..."
$CodeQLBundlePath = Start-DownloadWithRetry -Url "https://github.com/github/codeql-action/releases/download/$CodeQLBundleName/codeql-bundle.tar.gz" -Name "codeql-bundle.tar.gz"
$DownloadDirectoryPath = (Get-Item $CodeQLBundlePath).Directory.FullName
Extract-7Zip -Path $CodeQLBundlePath -DestinationPath $DownloadDirectoryPath
$UnGzipedCodeQLBundlePath = Join-Path $DownloadDirectoryPath "codeql-bundle.tar"
Extract-7Zip -Path $UnGzipedCodeQLBundlePath -DestinationPath $ExtractionDirectory

# Test that the tool has been extracted successfully.
$Env:CODEQL_EXTRACTION_DIRECTORY = $ExtractionDirectory
Invoke-PesterTests -TestFile "Tools" -TestName "CodeQLBundle"

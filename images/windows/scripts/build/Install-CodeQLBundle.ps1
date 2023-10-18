################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the CLI version of the latest CodeQL bundle.
$Defaults = (Invoke-RestMethod "https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json")
$CliVersion = $Defaults.cliVersion
$TagName = "codeql-bundle-v" + $CliVersion

Write-Host "Downloading CodeQL bundle $($CliVersion)..."
# Note that this is the all-platforms CodeQL bundle, to support scenarios where customers run
# different operating systems within containers.
$CodeQLBundlePath = Start-DownloadWithRetry -Url "https://github.com/github/codeql-action/releases/download/$($TagName)/codeql-bundle.tar.gz" -Name "codeql-bundle.tar.gz"
$DownloadDirectoryPath = (Get-Item $CodeQLBundlePath).Directory.FullName

$CodeQLToolcachePath = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath $CliVersion | Join-Path -ChildPath "x64"
New-Item -Path $CodeQLToolcachePath -ItemType Directory -Force | Out-Null

Write-Host "Unpacking the downloaded CodeQL bundle archive..."
Extract-7Zip -Path $CodeQLBundlePath -DestinationPath $DownloadDirectoryPath
$UnGzipedCodeQLBundlePath = Join-Path $DownloadDirectoryPath "codeql-bundle.tar"
Extract-7Zip -Path $UnGzipedCodeQLBundlePath -DestinationPath $CodeQLToolcachePath

Write-Host "CodeQL bundle at $($CodeQLToolcachePath) contains the following directories:"
Get-ChildItem -Path $CodeQLToolcachePath -Depth 2

# Touch a file to indicate to the CodeQL Action that this bundle shipped with the toolcache. This is
# to support overriding the CodeQL version specified in defaults.json on GitHub Enterprise.
New-Item -ItemType file (Join-Path $CodeQLToolcachePath -ChildPath "pinned-version")

# Touch a file to indicate to the toolcache that setting up CodeQL is complete.
New-Item -ItemType file "$CodeQLToolcachePath.complete"

# Test that the tools have been extracted successfully.
Invoke-PesterTests -TestFile "Tools" -TestName "CodeQL Bundle"

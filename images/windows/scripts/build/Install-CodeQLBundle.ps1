################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the CLI version of the latest CodeQL bundle.
$defaults = (Invoke-RestMethod "https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json")
$cliVersion = $defaults.cliVersion
$tagName = "codeql-bundle-v" + $cliVersion

Write-Host "Downloading CodeQL bundle $($cliVersion)..."
# Note that this is the all-platforms CodeQL bundle, to support scenarios where customers run
# different operating systems within containers.
$codeQLBundlePath = Invoke-DownloadWithRetry "https://github.com/github/codeql-action/releases/download/$($tagName)/codeql-bundle.tar.gz"
$downloadDirectoryPath = (Get-Item $codeQLBundlePath).Directory.FullName

$codeQLToolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath $cliVersion | Join-Path -ChildPath "x64"
New-Item -Path $codeQLToolcachePath -ItemType Directory -Force | Out-Null

Write-Host "Unpacking the downloaded CodeQL bundle archive..."
Expand-7ZipArchive -Path $codeQLBundlePath -DestinationPath $downloadDirectoryPath
$unGzipedCodeQLBundlePath = Join-Path $downloadDirectoryPath "codeql-bundle.tar"
Expand-7ZipArchive -Path $unGzipedCodeQLBundlePath -DestinationPath $codeQLToolcachePath

Write-Host "CodeQL bundle at $($codeQLToolcachePath) contains the following directories:"
Get-ChildItem -Path $codeQLToolcachePath -Depth 2

# Touch a file to indicate to the CodeQL Action that this bundle shipped with the toolcache. This is
# to support overriding the CodeQL version specified in defaults.json on GitHub Enterprise.
New-Item -ItemType file (Join-Path $codeQLToolcachePath -ChildPath "pinned-version")

# Touch a file to indicate to the toolcache that setting up CodeQL is complete.
New-Item -ItemType file "$codeQLToolcachePath.complete"

# Test that the tools have been extracted successfully.
Invoke-PesterTests -TestFile "Tools" -TestName "CodeQL Bundle"

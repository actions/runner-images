################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
$Defaults = (Invoke-RestMethod "https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json")
$CodeQLTagName = $Defaults.bundleVersion
$CodeQLCliVersion = $Defaults.cliVersion
$PriorCodeQLTagName = $Defaults.priorBundleVersion
$PriorCodeQLCliVersion = $Defaults.priorCliVersion

# Convert the tag names to bundles with a version number (x.y.z-YYYYMMDD).
$CodeQLBundleVersion = $CodeQLCliVersion + "-" + $CodeQLTagName.split("-")[-1]
$PriorCodeQLBundleVersion = $PriorCodeQLCliVersion + "-" + $PriorCodeQLTagName.split("-")[-1]

$Bundles = @(
    [PSCustomObject]@{
        TagName=$CodeQLTagName; 
        BundleVersion=$CodeQLBundleVersion;
    }
    [PSCustomObject]@{
        TagName=$PriorCodeQLTagName; 
        BundleVersion=$PriorCodeQLBundleVersion;
    }
)

foreach ($Bundle in $Bundles) {
    Write-Host "Downloading CodeQL bundle ${Bundle.BundleVersion}..."
    $CodeQLBundlePath = Start-DownloadWithRetry -Url "https://github.com/github/codeql-action/releases/download/${Bundle.TagName}/codeql-bundle.tar.gz" -Name "codeql-bundle.tar.gz"
    DownloadDirectoryPath = (Get-Item $CodeQLBundlePath).Directory.FullName

    $CodeQLToolcachePath = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath $Bundle.BundleVersion | Join-Path -ChildPath "x64"
    New-Item -Path $CodeQLToolcachePath -ItemType Directory -Force | Out-Null

    Write-Host "Unpacking the downloaded CodeQL bundle archive..."
    Extract-7Zip -Path $CodeQLBundlePath -DestinationPath $DownloadDirectoryPath
    $UnGzipedCodeQLBundlePath = Join-Path $DownloadDirectoryPath "codeql-bundle.tar"
    Extract-7Zip -Path $UnGzipedCodeQLBundlePath -DestinationPath $CodeQLToolcachePath

    # Touch a file to indicate to the toolcache that setting up CodeQL is complete.
    New-Item -ItemType file "$CodeQLToolcachePath.complete"

    # Test that the tool has been extracted successfully.
    Invoke-PesterTests -TestFile "Tools" -TestName "CodeQLBundle"
}

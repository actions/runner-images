################################################################################
##  File:  Install-CodeQLBundle.ps1
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the CLI versions and bundle tags of the latest two CodeQL bundles.
$Defaults = (Invoke-RestMethod "https://raw.githubusercontent.com/github/codeql-action/v2/src/defaults.json")
$CodeQLTagName = $Defaults.bundleVersion
$CodeQLCliVersion = $Defaults.cliVersion
$PriorCodeQLTagName = $Defaults.priorBundleVersion
$PriorCodeQLCliVersion = $Defaults.priorCliVersion

# Compute the toolcache version number for each bundle. This is either `x.y.z` or `x.y.z-YYYYMMDD`.
if ($CodeQLTagName.split("-")[-1].StartsWith("v")) {
    # Tag name of the format `codeql-bundle-vx.y.z`, where x.y.z is the CLI version.
    # We don't need to include the tag name in the toolcache version number because it's derivable
    # from the CLI version.
    $CodeQLBundleVersion = $CodeQLCliVersion
} elseif ($CodeQLTagName.split("-")[-1] -match "^\d+$") {
    # Tag name of the format `codeql-bundle-YYYYMMDD`.
    # We need to include the tag name in the toolcache version number because it can't be derived
    # from the CLI version.
    $CodeQLBundleVersion = $CodeQLCliVersion + "-" + $CodeQLTagName.split("-")[-1]
} else {
    Write-Error "Unrecognised current CodeQL bundle tag name: $CodeQLTagName. Could not compute toolcache version number."
    exit 1
}
if ($PriorCodeQLTagName.split("-")[-1].StartsWith("v")) {
    # Tag name of the format `codeql-bundle-vx.y.z`, where x.y.z is the CLI version.
    # We don't need to include the tag name in the toolcache version number because it's derivable
    # from the CLI version.
    $PriorCodeQLBundleVersion = $PriorCodeQLCliVersion
} elseif ($PriorCodeQLTagName.split("-")[-1] -match "^\d+$") {
    # Tag name of the format `codeql-bundle-YYYYMMDD`.
    # We need to include the tag name in the toolcache version number because it can't be derived
    # from the CLI version.
    $PriorCodeQLBundleVersion = $PriorCodeQLCliVersion + "-" + $PriorCodeQLTagName.split("-")[-1]
} else {
    Write-Error "Unrecognised prior CodeQL bundle tag name: $PriorCodeQLTagName. Could not compute toolcache version number."
    exit 1
}

$Bundles = @(
    [PSCustomObject]@{
        TagName=$CodeQLTagName; 
        BundleVersion=$CodeQLBundleVersion;
    },
    [PSCustomObject]@{
        TagName=$PriorCodeQLTagName; 
        BundleVersion=$PriorCodeQLBundleVersion;
    }
)

foreach ($Bundle in $Bundles) {
    Write-Host "Downloading CodeQL bundle $($Bundle.BundleVersion)..."
    $CodeQLBundlePath = Start-DownloadWithRetry -Url "https://github.com/github/codeql-action/releases/download/$($Bundle.TagName)/codeql-bundle.tar.gz" -Name "codeql-bundle.tar.gz"
    $DownloadDirectoryPath = (Get-Item $CodeQLBundlePath).Directory.FullName

    $CodeQLToolcachePath = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath $Bundle.BundleVersion | Join-Path -ChildPath "x64"
    New-Item -Path $CodeQLToolcachePath -ItemType Directory -Force | Out-Null

    Write-Host "Unpacking the downloaded CodeQL bundle archive..."
    Extract-7Zip -Path $CodeQLBundlePath -DestinationPath $DownloadDirectoryPath
    $UnGzipedCodeQLBundlePath = Join-Path $DownloadDirectoryPath "codeql-bundle.tar"
    Extract-7Zip -Path $UnGzipedCodeQLBundlePath -DestinationPath $CodeQLToolcachePath

    # We only pin the latest version in the toolcache, to support overriding the CodeQL version specified in defaults.json on GitHub Enterprise.
    if ($Bundle.BundleVersion -eq $CodeQLBundleVersion) {
        New-Item -ItemType file (Join-Path $CodeQLToolcachePath -ChildPath "pinned-version")
    }

    # Touch a file to indicate to the toolcache that setting up CodeQL is complete.
    New-Item -ItemType file "$CodeQLToolcachePath.complete"
}

# Test that the tools have been extracted successfully.
Invoke-PesterTests -TestFile "Tools" -TestName "CodeQLBundles"

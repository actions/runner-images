################################################################################
##  File:  Install-Go.ps1
##  Desc:  Install Go
################################################################################

Import-Module -Name ImageHelpers -Force

$refsJson = Invoke-RestMethod "https://api.github.com/repos/golang/go/git/refs/tags"

function Install-GoVersion
{
    Param
    (
        [String] $goVersion,
        [Switch] $addToDefaultPath
    )

    $latestVersionObject = $refsJson | Where-Object { $_.ref -Match "refs/tags/go$goVersion[./d]*" }  | Select-Object -Last 1
    $latestVersion = $latestVersionObject.ref.replace('refs/tags/go','')

    # Download the Go zip archive.
    Write-Host "Downloading Go $latestVersion..."
    $ProgressPreference = 'SilentlyContinue'

    $goArchName = "go${latestVersion}.windows-amd64.zip"
    $goArchUrl = "https://dl.google.com/go/${goArchName}"

    $goArchPath = Start-DownloadWithRetry -Url $goArchUrl -Name $goArchName

    # Extract the zip archive.  It contains a single directory named "go".
    Write-Host "Extracting Go $latestVersion..."
    $toolDirectory = Join-Path $env:AGENT_TOOLSDIRECTORY "go\$latestVersion"
    7z.exe x $goArchPath -o"$toolDirectory" -y | Out-Null

    # Rename the extracted "go" directory to "x64" for full path "C:\hostedtoolcache\windows\Go\1.14.2\x64\..."
    Rename-Item -path "$toolDirectory\go" -newName "x64"
    $fullArchPath = "$toolDirectory\x64"

    # Delete unnecessary files to conserve space
    Write-Host "Cleaning directories of Go $latestVersion..."
    if (Test-Path "$fullArchPath\doc")
    {
        Remove-Item -Recurse -Force "$fullArchPath\doc"
    }
    if (Test-Path "$fullArchPath\blog")
    {
        Remove-Item -Recurse -Force "$fullArchPath\blog"
    }

    # Create symlink in old location
    New-Item -Path "C:\go$latestVersion" -ItemType SymbolicLink -Value $fullArchPath

    # Make this the default version of Go?
    if ($addToDefaultPath)
    {
        Write-Host "Adding Go $latestVersion to the path..."
        # Add the Go binaries to the path.
        Add-MachinePathItem "$fullArchPath\bin" | Out-Null
        # Set the GOROOT environment variable.
        setx GOROOT "$fullArchPath" /M | Out-Null
    }

    # Done
    Write-Host "Done installing Go $latestVersion."
    return $fullArchPath
}

# Install Go
$goVersionsToInstall = $env:GO_VERSIONS.split(", ", [System.StringSplitOptions]::RemoveEmptyEntries)

foreach ($go in $goVersionsToInstall)
{
    Write-Host "Installing Go ${go}"
    if ($go -eq $env:GO_DEFAULT)
    {
        $installDirectory = Install-GoVersion -goVersion $go -addToDefaultPath
    }
    else
    {
        $installDirectory = Install-GoVersion -goVersion $go
    }

    $envName = "GOROOT_{0}_{1}_X64" -f $go.split(".")
    setx $envName "$installDirectory" /M
}

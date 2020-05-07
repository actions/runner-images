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
    Expand-Archive -Path $goArchPath -DestinationPath "C:\" -Force

    # Delete unnecessary files to conserve space
    Write-Host "Cleaning directories of Go $latestVersion..."
    if (Test-Path "C:\go\doc")
    {
        Remove-Item -Recurse -Force "C:\go\doc"
    }
    if (Test-Path "C:\go\blog")
    {
        Remove-Item -Recurse -Force "C:\go\blog"
    }

    # Rename the extracted "go" directory to include the Go version number (to support side-by-side versions of Go).
    $newDirName = "Go$latestVersion"
    Rename-Item -path "C:\go" -newName $newDirName

    # Make this the default version of Go?
    if ($addToDefaultPath)
    {
        Write-Host "Adding Go $latestVersion to the path..."
        # Add the Go binaries to the path.
        Add-MachinePathItem "C:\$newDirName\bin" | Out-Null
        # Set the GOROOT environment variable.
        setx GOROOT "C:\$newDirName" /M | Out-Null
    }

    # Done
    Write-Host "Done installing Go $latestVersion."
    return "C:\$newDirName"
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

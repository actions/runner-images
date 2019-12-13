################################################################################
##  File:  Install-Go.ps1
##  Desc:  Install Go
################################################################################

Import-Module -Name ImageHelpers -Force

function Install-GoVersion
{
    Param
    (
        [String]$goVersion,
        [Switch]$addToDefaultPath
    )

    # Download the Go zip archive.
    Write-Host "Downloading Go $goVersion..."
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -UseBasicParsing -Uri "https://dl.google.com/go/go$goVersion.windows-amd64.zip" -OutFile go$goVersion.windows-amd64.zip

    # Extract the zip archive.  It contains a single directory named "go".
    Write-Host "Extracting Go $goVersion..."
    Expand-Archive -Path go$goVersion.windows-amd64.zip -DestinationPath "C:\" -Force

    # Delete unnecessary files to conserve space
    Write-Host "Cleaning directories of Go $goVersion..."
    if (Test-Path "C:\go\doc")
    {
        Remove-Item -Recurse -Force "C:\go\doc"
    }
    if (Test-Path "C:\go\blog")
    {
        Remove-Item -Recurse -Force "C:\go\blog"
    }

    # Rename the extracted "go" directory to include the Go version number (to support side-by-side versions of Go).
    $newDirName = "Go$goVersion"
    Rename-Item -path "C:\go" -newName $newDirName

    # Delete the Go zip archive.
    Write-Host "Deleting downloaded archive of Go $goVersion..."
    Remove-Item go$goVersion.windows-a`md64.zip

    # Make this the default version of Go?
    if ($addToDefaultPath)
    {
        Write-Host "Adding Go $goVersion to the path..."
        # Add the Go binaries to the path.
        Add-MachinePathItem "C:\$newDirName\bin" | Out-Null
        # Set the GOROOT environment variable.
        setx GOROOT "C:\$newDirName" /M | Out-Null
    }

    # Done
    Write-Host "Done installing Go $goVersion."
    return "C:\$newDirName"
}

# Install Go
$goVersionsToInstall = $env:GO_VERSIONS.split(",")

foreach($go in $goVersionsToInstall) {
    Write-Host "Installing Go ${go}"
    if($go -eq $env:GO_DEFAULT) {
        $installDirectory = Install-GoVersion -goVersion $go -addToDefaultPath
    } else {
        $installDirectory = Install-GoVersion -goVersion $go
    }
    $envName = "GOROOT_{0}_{1}_X64" -f $go.split(".")	
    setx $envName "$installDirectory" /M
}

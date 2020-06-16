################################################################################
##  File:  Validate-Go.ps1
##  Desc:  Validate Go
################################################################################

# Function that gets the version of Go at the specified path
function Get-GoVersion
{
    Param
    (
        [String]$goVersion
    )
    Write-Host "Check if $goVersion is presented in the system"
    $destinationPath = "$($env:AGENT_TOOLSDIRECTORY)\go"
    $goDirectory = Get-ChildItem -Path $destinationPath -Filter "$goVersion*" | Select-Object -First 1
    $goPath = Join-Path $destinationPath "$goDirectory\x64"

    $env:Path = "$goPath\bin;" + $env:Path
    $version = $(go version)

    $matchVersion = $version -match $goVersion
    $semanticEquality = $version -match 'go version go(?<version>.*) win.*'

    if($semanticEquality -And $matchVersion)
    {
        $goFullVersion = $Matches.version
        Write-Host "$goFullVersion has been found"
    }
    else
    {
        Write-Host "Unable to determine Go version at " + $goPath
        exit 1
    }
}

# Verify that go.exe is on the path
if(Get-Command -Name 'go')
{
    Write-Host "$(go version) is on the path."
}
else
{
    Write-Host "Go is not on the path."
    exit 1
}

$goVersionsToInstall = $env:GO_VERSIONS.split(", ", [System.StringSplitOptions]::RemoveEmptyEntries)
foreach($go in $goVersionsToInstall) {
    Get-GoVersion -goVersion $go
}

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
    $DestinationPath = "$($env:SystemDrive)\"
    $goDirectory = Get-ChildItem -Path $DestinationPath -Filter "Go$goVersion*" | Select-Object -First 1
    $goPath = Join-Path $env:SystemDrive $goDirectory

    $env:Path = "$goPath\bin;" + $env:Path
    $version = $(go version)

    $matchVersion = $version -match $goVersion
    $semanticEquality = $version -match 'go version go(?<version>.*) win.*'

    if($semanticEquality -And $matchVersion)
    {
        $goFullVersion = $Matches.version
        Write-Host "$goFullVersion has been found"

        return $goFullVersion
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

# Add details of available versions in Markdown
$tmplMark = @"
#### {0}

_Environment:_
* {1}: root directory of the Go {0} installation

"@

$tmplMarkRoot = @"
#### {0}

_Environment:_
* PATH: contains the location of go.exe version {0}
* GOROOT: root directory of the Go {0} installation
* {1}: root directory of the Go {0} installation
"@

$SoftwareName = "Go (x64)"
$Description = New-Object System.Text.StringBuilder
$goVersionsToInstall = $env:GO_VERSIONS.split(", ", [System.StringSplitOptions]::RemoveEmptyEntries)

foreach($go in $goVersionsToInstall) {
    $goVersion = Get-GoVersion -goVersion $go
    $goVersionTag = "GOROOT_{0}_{1}_X64" -f $go.split(".")
    if ($goVersion -eq $go) {
        if($go -eq $env:GO_DEFAULT) {
            $null = $Description.AppendLine(($tmplMarkRoot -f $goVersion, $goVersionTag))
        } else {
            $null = $Description.AppendLine(($tmplMark -f $goVersion, $goVersionTag))
        }
    }
}

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description.ToString()

################################################################################
##  File:  Validate-Go.ps1
##  Desc:  Validate Go
################################################################################

# Function that gets the version of Go at the specified path
function Get-GoVersion
{
    Param
    (
        [String]$goRootPath
    )

    $env:Path = "$goRootPath\bin;" + $env:Path
    if( $(go version) -match 'go version go(?<version>.*) win.*' )
    {
        $goVersion = $Matches.version
        return $goVersion
    }

    Write-Host "Unable to determine Go version at " + $goRootPath
    return ""
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
$goVersionsToInstall = $env:GO_VERSIONS.split(",")

foreach($go in $goVersionsToInstall) {
    $goVersion = Get-GoVersion -goRootPath "C:\Go${go}"
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

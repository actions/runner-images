using module ./SoftwareReport.psm1
using module ./SoftwareReport.DifferenceCalculator.psm1

<#
.SYNOPSIS
    Calculates the difference between two software reports and saves it to a file.
.PARAMETER PreviousJsonReportPath
    Path to the previous software report.
.PARAMETER CurrentJsonReportPath
    Path to the current software report.
.PARAMETER OutputFile
    Path to the file where the difference will be saved.
.PARAMETER ReleaseBranchName
    Name of the release branch to build image docs URL.
.PARAMETER ReadmePath
    Path to the README file in repository to build image docs URL.
#>

Param (
    [Parameter(Mandatory=$true)]
    [string] $PreviousJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $CurrentJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $OutputFile,
    [Parameter(Mandatory=$false)]
    [string] $ReleaseBranchName,
    [Parameter(Mandatory=$false)]
    [string] $ReadmePath
)

$ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"

function Read-SoftwareReport {
    Param (
        [Parameter(Mandatory=$true)]
        [string] $JsonReportPath
    )

    if (-not (Test-Path $JsonReportPath)) {
        throw "File '$JsonReportPath' does not exist"
    }

    $jsonReport = Get-Content -Path $JsonReportPath -Raw
    $report = [SoftwareReport]::FromJson($jsonReport)
    return $report
}

$previousReport = Read-SoftwareReport -JsonReportPath $PreviousJsonReportPath
$currentReport = Read-SoftwareReport -JsonReportPath $CurrentJsonReportPath

$comparer = [SoftwareReportDifferenceCalculator]::new($previousReport, $currentReport)
$comparer.CompareReports()
$diff = $comparer.GetMarkdownReport()

if ($ReleaseBranchName -and $ReadmePath) {
    # https://github.com/actions/runner-images/blob/releases/macOS-12/20221215/images/macos/macos-12-Readme.md
    $ImageDocsUrl = "https://github.com/actions/runner-images/blob/${ReleaseBranchName}/${ReadmePath}"
    $diff += "`n`n`nFor comprehensive list of software installed on this image please click [here]($ImageDocsUrl)."
}

$parentDirectory = Split-Path $OutputFile -Parent
if (-not (Test-Path $parentDirectory)) { New-Item -Path $parentDirectory -ItemType Directory | Out-Null }

$diff | Out-File -Path $OutputFile -Encoding utf8NoBOM

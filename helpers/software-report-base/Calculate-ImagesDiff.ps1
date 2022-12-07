using module ./SoftwareReport.psm1
using module ./SoftwareReport.Comparer.psm1

<#
.SYNOPSIS
    Calculates the difference between two software reports and saves it to a file.
.PARAMETER PreviousJsonReportPath
    Path to the previous software report.
.PARAMETER CurrentJsonReportPath
    Path to the current software report.
.PARAMETER OutputFile
    Path to the file where the difference will be saved.
#>

Param (
    [Parameter(Mandatory=$true)]
    [string] $PreviousJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $CurrentJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $OutputFile,
    [Parameter(Mandatory=$false)]
    [string] $ImageDocsUrl = "https://google.com"
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

$comparer = [SoftwareReportComparer]::new($previousReport, $currentReport)
$comparer.CompareReports()
$diff = $comparer.GetMarkdownReport()

if ($ImageDocsUrl) {
    $diff += "`n`n`n For comprehensive list of software installed on this image please click [here]($ImageDocsUrl)."
}

$diff | Out-File -Path $OutputFile -Encoding utf8NoBOM

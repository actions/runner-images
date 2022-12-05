using module ./SoftwareReport.Base.psm1
using module ./SoftwareReport.Comparer.psm1

Param (
    [Parameter(Mandatory=$true)]
    [string] $PreviousJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $CurrentJsonReportPath,
    [Parameter(Mandatory=$true)]
    [string] $OutputFile
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
$diff = $comparer.GetMarkdownResults()
$diff | Out-File -Path $OutputFile -Encoding utf8NoBOM

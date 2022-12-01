using module ./SoftwareReport.Base.psm1
using module ./SoftwareReport.Comparer.psm1
Import-Module $(Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -Force

$ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"

# Create report
$softwareReport = [SoftwareReport]::new("Ubuntu 22.04.1 LTS")

$softwareReport.Root.AddToolNode("OS Version:", "macOS 11.7 (20G817)")
$softwareReport.Root.AddToolNode("Image Version:", "20220918.1")

# Add tools
$installedSoftware = $softwareReport.Root.AddHeaderNode("Installed Software")


$languagesAndRuntimes = $installedSoftware.AddHeaderNode("Language and Runtime")
$languagesAndRuntimes.AddToolNode("Bash", $(Get-BashVersion))
$languagesAndRuntimes.AddToolNode("Node.js", $(Get-NodeVersion))
$languagesAndRuntimes.AddToolNode("Perl", $(Get-PerlVersion))
$languagesAndRuntimes.AddToolNode("Swift", $(Get-SwiftVersion))

$cachedTools = $installedSoftware.AddHeaderNode("Cached Tools")
$cachedTools.AddNode($(Get-ToolcacheRubyVersions))
$cachedTools.AddNode($(Get-ToolcacheGoVersions))

$addedTable = $languagesAndRuntimes.AddHeaderNode("Added tool table")
$addedTable.AddTableNode(@(
    [PSCustomObject] @{ A = "P1"; B = "P2" },
    [PSCustomObject] @{ A = "P3"; B = "P4" }
))

$installedSoftware.AddNode($(Get-JavaVersionsTable))

$mySQLSection = $installedSoftware.AddHeaderNode("MySQL")
$mySQLSection.AddToolNode("MySQL", $(Get-MySQLVersion))
$mySQLSection.AddToolNode("MySQL Server", $(Get-MySQLServerVersion))
$mySQLSection.AddNoteNode(@'
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
'@)

# Convert to JSON
$jsonReport = $softwareReport.ToJson()
$jsonReport | Out-File -Path $(Join-Path $PSScriptRoot "out.json")

# Parse report from JSON again from validation
$parsedReport = [SoftwareReport]::FromJson($jsonReport)

# Convert to markdown
$markdownReport = $parsedReport.ToMarkdown()
$markdownReport | Out-File -Path $(Join-Path $PSScriptRoot "out.md")

# Read old fake report
$oldReportJsonString = Get-Content -Path $(Join-Path $PSScriptRoot "oldReport.json") -Raw
$oldReport = [SoftwareReport]::FromJson($oldReportJsonString)

# Compare reports
$comparer = [SoftwareReportComparer]::new($oldReport, $parsedReport)
$comparer.CompareReports()
$diff = $comparer.GetMarkdownResults()
$diff | Out-File -Path $(Join-Path $PSScriptRoot "diff.md")
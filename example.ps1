using module ./helpers/software-report-base/SoftwareReport.psm1
using module ./helpers/software-report-base/SoftwareReport.Nodes.psm1
using module ./helpers/software-report-base/SoftwareReport.Comparer.psm1

$ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"

# All these functions just use mocked data for now to simplify local testing

function Get-ToolcacheRubyVersions {
    # just mock ruby versions array for now
    $rubyVersions = @("2.7", "2.8.1", "3.1.2")
    return [ToolVersionsListNode]::new("Ruby", $rubyVersions, $True)
}

function Get-ToolcacheGoVersions {
    # just mock go versions array for now
    $goVersions = @("1.17.13", "1.18.7", "1.19.2")
    return [ToolVersionsListNode]::new("Go", $goVersions, $False)
}

function Get-JavaVersionsTable {
    $javaNode = [HeaderNode]::new("Java")

    $javaVersions = @("8.0.345+1", "11.0.16+1", "17.0.4+1")
    $table = $javaVersions | ForEach-Object {
        $javaVersion = $_
        $vendor = "Eclipse Temurin"
        $majorVersion = $javaVersion.Split(".")[0]
        $envVar = "JAVA_HOME_$($majorVersion)_X64"

        return [PSCustomObject] @{
            "Version" = $javaVersion
            "Vendor" = $vendor
            "Environment Variables" = $envVar
        }
    }

    $javaNode.AddTableNode($table)

    return $javaNode
}

function Get-BashVersion {
    "5.1.16(1)-release"
}

function Get-NodeVersion {
    "16.18.0"
}

function Get-PerlVersion {
    "5.34.0"
}

function Get-SwiftVersion {
    "5.7"
}

function Get-MySQLVersion {
    "8.0.31-0ubuntu0.20.04.1"
}

function Get-MySQLServerVersion {
    "8.0.26"
}

# Create report
$softwareReport = [SoftwareReport]::new("Ubuntu 22.04.1 LTS")

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

# Convert to JSON
$jsonReport = $softwareReport.ToJson()
$jsonReport | Out-File -Path $(Join-Path $PSScriptRoot "out.json")

# Parse report from JSON again from validation
$parsedReport = [SoftwareReport]::FromJson($jsonReport)

# Convert to markdown
$markdownReport = $parsedReport.ToMarkdown()
$markdownReport | Out-File -Path $(Join-Path $PSScriptRoot "out.md")

# Read old fake report
#$oldReportJsonString = Get-Content -Path $(Join-Path $PSScriptRoot "oldReport.json") -Raw
#$oldReport = [SoftwareReport]::FromJson($oldReportJsonString)

# Compare reports
#$comparer = [SoftwareReportComparer]::new($oldReport, $parsedReport)
#$comparer.CompareReports()
#$diff = $comparer.GetMarkdownResults()
#$diff | Out-File -Path $(Join-Path $PSScriptRoot "diff.md")
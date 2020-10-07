param (
    [Parameter(Mandatory=$true)]
    $WorkingDirectory,
    [Parameter(Mandatory=$true)]
    $OutputFile
)

$ErrorActionPreference = "Stop"

Import-Module Pester
Set-Location -Path $WorkingDirectory

$configuration = [PesterConfiguration] @{
    Output = @{ Verbosity = "Detailed" }
    TestResult = @{
        Enabled = $true
        OutputPath = $OutputFile;
        OutputFormat = "NUnitXML"
    }
}

Invoke-Pester -Configuration $configuration
Invoke-PesterTests "*"

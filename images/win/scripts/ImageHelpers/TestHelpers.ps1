function Get-CommandResult {
    Param (
        [Parameter(Mandatory)][string] $Command,
        [switch] $Multiline
    )
    $exitCode = $LASTEXITCODE
    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

# Gets path to the tool, analogue of 'which tool'
function Get-WhichTool {
    Param (
        [Parameter(Mandatory)][string] $Tool
    )
    return (Get-Command $Tool).Path
}

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}

# TO-DO: Better naming is required
function Run-ToolTest {
    Param(
        [Parameter(Mandatory)][string] $ToolName
    )

    $testsDirectory = Join-Path (Split-Path -Parent $PSScriptRoot) "Tests"
    $testPath = Join-Path $testsDirectory "${ToolName}.Tests.ps1"

    if (-not (Test-Path $testPath)) {
        # TO-DO: Make sure that throw will fail packer build
        throw "Unable to run tests for tool '$ToolName'. Unknown tool"
    }
    Invoke-Pester -Script $testPath -EnableExit
}

function ShouldReturnZeroExitCode {
    Param(
        [Parameter (Mandatory = $true)] [ValidateNotNullOrEmpty()]
        [String]$ActualValue,
        [switch]$Negate
    )

    Write-Host "Run command '${ActualValue}'"
    Invoke-Expression -Command $ActualValue | ForEach-Object { Write-Host $_ }
    $actualExitCode = $LASTEXITCODE

    [bool]$succeeded = $actualExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}"
    }

    return New-Object PSObject -Property @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-AssertionOperator -Name ReturnZeroExitCode -Test  $function:ShouldReturnZeroExitCode

# TO-DO: Need to validate that ImageHelpers scripts are deleted from image at the end of image-generation
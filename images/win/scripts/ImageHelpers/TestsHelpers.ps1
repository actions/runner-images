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
function Run-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testsDirectory = Join-Path "C:\image" "Tests"
    $testPath = Join-Path $testsDirectory "${TestFile}.Tests.ps1"

    if (-not (Test-Path $testPath)) {
        # TO-DO: Make sure that throw will fail packer build
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }
    Invoke-Pester -Script $testPath -TestName $TestName -EnableExit
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

function Validate-ZeroExitCode($command) {
    $result = Get-CommandResult $command
    $result.ExitCode
}

if (Get-Module Pester) {
    Add-AssertionOperator -Name ReturnZeroExitCode -Test  $function:ShouldReturnZeroExitCode
}


# TO-DO: Need to validate that ImageHelpers scripts are deleted from image at the end of image-generation
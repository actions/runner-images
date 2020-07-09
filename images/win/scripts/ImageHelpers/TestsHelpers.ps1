function Get-CommandResult {
    Param (
        [Parameter(Mandatory)][string] $Command
    )
    # CMD trick to suppress and show error output because some commands write to stderr (for example, "java -version")
    [string[]]$output = cmd /c "$Command 2>&1"

    $exitCode = $LASTEXITCODE
    return @{
        Output = $output
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

function Update-Environment {
    $variables = [Environment]::GetEnvironmentVariables("Machine")
    $variables.Keys | ForEach-Object {
        $key = $_
        $value = $variables[$key]
        Set-Item -Path "env:$key" -Value $value
    }
    # We need to refresh PATH the latest one because it could include other variables "%M2_HOME%/bin"
    $env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
}

function Invoke-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testPath = "C:\image\Tests\${TestFile}.Tests.ps1"

    if (-not (Test-Path $testPath)) {
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    Update-Environment
    $configuration = [PesterConfiguration] @{
        Run = @{
            Path = $testPath
            PassThru = $true
        }
        Output = @{
            Verbosity = "Detailed"
        }
    }
    if ($TestName) {
        $configuration.Filter.FullName = $TestName
    }

    $results = Invoke-Pester -Configuration $configuration
    if (-not ($results -and ($results.FailedCount -eq 0) -and ($results.PassedCount -gt 0))) {
        $results
        throw "Test run has finished with errors"
    }
}

function ShouldReturnZeroExitCode {
    Param(
        [String]$ActualValue,
        [switch]$Negate,
        [string] $Because
    )

    $result = Get-CommandResult $ActualValue

    [bool]$succeeded = $result.ExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        # log detailed output in case of fail
        $result.Output | ForEach-Object { Write-Host $_ }
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}"
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

If (Get-Command -Name Add-AssertionOperator -ErrorAction SilentlyContinue) {
    Add-AssertionOperator -Name ReturnZeroExitCode -InternalName ShouldReturnZeroExitCode -Test ${function:ShouldReturnZeroExitCode}
}
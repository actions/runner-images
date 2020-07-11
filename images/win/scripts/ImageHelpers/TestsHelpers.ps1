function Get-CommandResult {
    Param (
        [Parameter(Mandatory)][string] $Command
    )
    # CMD trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    [string[]]$output = & $env:comspec /c "$Command 2>&1"
    $exitCode = $LASTEXITCODE

    return @{
        Output = $output
        ExitCode = $exitCode
    }
}

# Gets path to the tool, analogue of 'which tool'
function Get-WhichTool($tool) {
    return (Get-Command $tool).Path
}

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}

# Update environment variables without reboot
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

# Run Pester tests for specific tool
function Invoke-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testPath = "C:\image\Tests\${TestFile}.Tests.ps1"
    if (-not (Test-Path $testPath)) {
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    $configuration = [PesterConfiguration] @{
        Run = @{ Path = $testPath; PassThru = $true }
        Output = @{ Verbosity = "Detailed" }
    }
    if ($TestName) {
        $configuration.Filter.FullName = $TestName
    }

    # Update environment variables without reboot
    Update-Environment

    # Switch ErrorActionPreference to Stop temporary to make sure that tests will on silent errors too
    $backupErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    $results = Invoke-Pester -Configuration $configuration
    $ErrorActionPreference = $backupErrorActionPreference

    # Fail in case if no tests are run
    if (-not ($results -and ($results.FailedCount -eq 0) -and ($results.PassedCount -gt 0))) {
        $results
        throw "Test run has failed"
    }
}
Import-Module Pester

function Invoke-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testPath = "/imagegeneration/tests/${TestFile}.Tests.ps1"
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

Invoke-PesterTests "*"

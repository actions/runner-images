Import-Module "$PSScriptRoot/Common.Helpers.psm1"

# Validates that tool is installed and in PATH
function Validate-ToolExist($tool) {
    Get-Command $tool -ErrorAction SilentlyContinue | Should -BeTrue
}

function Validate-ArrayWithoutDuplicates {
    param (
        [AllowEmptyCollection()]
        [Parameter(Mandatory = $true)]
        [array] $Items,
        [string] $Because
    )
    $uniqueList = @()
    $Items | ForEach-Object {
        $uniqueList | Should -Not -Contain $_ -Because $Because
        $uniqueList += $_
    }
}

function Validate-Url {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Url
    )

    $result = $true
    try {
        $requestResult = Invoke-WebRequest $Url -DisableKeepAlive -UseBasicParsing -Method Head
        $result = ($requestResult.StatusCode -eq 200)
    } catch {
        $result = $false
    }

    $result | Should -BeTrue -Because "'$Url' should be available, but it is not"
}

function Validate-IdenticalFileContent {
    param (
        [Parameter(Mandatory)]
        [string] $File1,
        [Parameter(Mandatory)]
        [string] $File2
    )

    $File1 | Should -Exist -Because "The content of '$File1' should be identical with content of '$File2' but '$File1' doesn't exist"
    $File2 | Should -Exist -Because "The content of '$File1' should be identical with content of '$File2' but '$File2' doesn't exist"

    $content1 = Get-Content -Raw $File1
    $content2 = Get-Content -Raw $File2
    $content1 | Should -Be $content2 -Because "The content of '$File1' should be identical with content of '$File2' but they are different"
}

function ShouldReturnZeroExitCode {
    Param(
        [String] $ActualValue,
        [switch] $Negate,
        [string] $Because # This parameter is unused by we need it to match Pester asserts signature
    )

    $result = Get-CommandResult $ActualValue

    [bool]$succeeded = $result.ExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        $commandOutputIndent = " " * 4
        $commandOutput = ($result.Output | ForEach-Object { "${commandOutputIndent}${_}" }) -join "`n"
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}`n${commandOutput}"
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

function ShouldMatchCommandOutput {
    Param(
        [String] $ActualValue,
        [String] $RegularExpression,
        [switch] $Negate
    )

    $output = (Get-CommandResult $ActualValue).Output | Out-String
    [bool] $succeeded = $output -cmatch $RegularExpression

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if (-not $succeeded) {
        if ($Negate) {
            $failureMessage = "Expected regular expression '$RegularExpression' for '$ActualValue' command to not match '$output', but it did match."
        }
        else {
            $failureMessage = "Expected regular expression '$RegularExpression' for '$ActualValue' command to match '$output', but it did not match."
        }
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

If (Get-Command -Name Add-ShouldOperator -ErrorAction SilentlyContinue) {
    Add-ShouldOperator -Name ReturnZeroExitCode -InternalName ShouldReturnZeroExitCode -Test ${function:ShouldReturnZeroExitCode}
    Add-ShouldOperator -Name MatchCommandOutput -InternalName ShouldMatchCommandOutput -Test ${function:ShouldMatchCommandOutput}
}

function Invoke-PesterTests {
    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testPath = "$HOME/image-generation/tests/${TestFile}.Tests.ps1"
    if (-not (Test-Path $testPath)) {
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    # Check that Pester module is imported
    if (!(Get-Module "Pester")) {
        Import-Module Pester
    }

    $configuration = [PesterConfiguration] @{
        Run = @{ Path = $testPath; PassThru = $true }
        Output = @{ Verbosity = "Detailed"; RenderMode = "Plaintext" }
    }
    if ($TestName) {
        $configuration.Filter.FullName = $TestName
    }

    # Switch ErrorActionPreference to make sure that tests will fail on silent errors too
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
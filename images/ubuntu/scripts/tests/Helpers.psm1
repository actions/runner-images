Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

function Invoke-PesterTests {
    <#
    .SYNOPSIS
        Runs Pester tests based on the provided test file and test name.

    .DESCRIPTION
        The Invoke-PesterTests function runs Pester tests based on the provided test file and test name.

    .PARAMETER TestFile
        The name of the test file to run. This should be the base name of the test file without the extension.
        Using "*" will run all tests from all test files.

    .PARAMETER TestName
        The name of the specific test to run. If provided, only the test with the matching name will be executed.

    .EXAMPLE
        Invoke-PesterTests -TestFile "MyTests" -TestName "Test1"
        Runs the test named "Test1" from the test file "MyTests.Tests.ps1".

    .EXAMPLE
        Invoke-PesterTests -TestFile "*"
        Runs all tests from all test files

    #>
    Param(
        [Parameter(Mandatory = $true)]
        [string] $TestFile,
        [string] $TestName
    )

    $testPath = "/imagegeneration/tests/${TestFile}.Tests.ps1"
    if (-not (Test-Path $testPath)) {
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    # Check that Pester module is imported
    if (-not (Get-Module "Pester")) {
        Import-Module Pester
    }

    $configuration = [PesterConfiguration] @{
        Run    = @{ Path = $testPath; PassThru = $true }
        Output = @{ Verbosity = "Detailed"; RenderMode = "Plaintext" }
    }
    if ($TestName) {
        $configuration.Filter.FullName = $TestName
    }

    # Switch ErrorActionPreference to Stop temporary to make sure that tests will fail on silent errors too
    $backupErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    $results = Invoke-Pester -Configuration $configuration
    $ErrorActionPreference = $backupErrorActionPreference

    # Fail in case if no tests are run
    if (-not ($results -and ($results.FailedCount -eq 0) -and (($results.PassedCount + $results.SkippedCount) -gt 0))) {
        $results
        throw "Test run has failed"
    }
}

function ShouldReturnZeroExitCode {
    <#
    .SYNOPSIS
        Implements a custom Should-operator for the Pester framework.

    .DESCRIPTION
        This function is used to check if a command has returned a zero exit code.
        It can be used by registering it using the Add-ShouldOperator function in Pester.

    .PARAMETER ActualValue
        The actual value to be checked.

    .PARAMETER Negate
        A switch parameter that, when specified, negates the result of the check.

    .PARAMETER Because
        An optional string that provides additional context or explanation for the check.

    .NOTES
        This function is designed to be used with the Pester framework.

    .LINK
        https://pester.dev/docs/assertions/custom-assertions
    #>
    Param(
        [string] $ActualValue,
        [switch] $Negate,
        [string] $Because # This parameter is unused but we need it to match Pester asserts signature
    )

    $result = Get-CommandResult $ActualValue -ValidateExitCode $false

    [bool] $succeeded = $result.ExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
        $commandOutputIndent = " " * 4
        $commandOutput = ($result.Output | ForEach-Object { "${commandOutputIndent}${_}" }) -join "`n"
        $failureMessage = "Command '${ActualValue}' has finished with exit code`n${commandOutput}"
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

function ShouldOutputTextMatchingRegex {
    <#
    .SYNOPSIS
        Implements a custom Should-operator for the Pester framework.

    .DESCRIPTION
        This function is used to check if a command outputs text that matches a regular expression.
        It can be used by registering it using the Add-ShouldOperator function in Pester.

    .PARAMETER ActualValue
        The actual value to be checked.

    .PARAMETER RegularExpression
        The regular expression to be used for the check.

    .PARAMETER Negate
        A switch parameter that, when specified, negates the result of the check.

    .NOTES
        This function is designed to be used with the Pester framework.

    .LINK
        https://pester.dev/docs/assertions/custom-assertions
    #>
    Param(
        [string] $ActualValue,
        [string] $RegularExpression,
        [switch] $Negate
    )

    $output = (Get-CommandResult $ActualValue -ValidateExitCode $false).Output | Out-String
    [bool] $succeeded = $output -cmatch $RegularExpression

    if ($Negate) { $succeeded = -not $succeeded }

    $failureMessage = ''

    if (-not $succeeded) {
        if ($Negate) {
            $failureMessage = "Expected regular expression '$RegularExpression' for '$ActualValue' command to not match '$output', but it did match."
        } else {
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
    Add-ShouldOperator -Name OutputTextMatchingRegex -InternalName ShouldOutputTextMatchingRegex -Test ${function:ShouldOutputTextMatchingRegex}
}

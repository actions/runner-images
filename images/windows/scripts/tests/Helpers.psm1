[CmdletBinding()]
param()

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable, "Machine")
}

function Invoke-PesterTests {
    <#
    .SYNOPSIS
        Runs Pester tests based on the provided test file and test name.

    .DESCRIPTION
        The Invoke-PesterTests function runs Pester tests based on the provided test file and test name.
        It supports filtering tests by name and generating test result output.

    .PARAMETER TestFile
        The name of the test file to run. This should be the base name of the test file without the extension.

    .PARAMETER TestName
        The name of the specific test to run. If provided, only the test with the matching name will be executed.

    .EXAMPLE
        Invoke-PesterTests -TestFile "MyTests" -TestName "Test1"
        Runs the test named "Test1" from the test file "MyTests.Tests.ps1".

    .EXAMPLE
        Invoke-PesterTests -TestFile "*" -TestName "Test2"
        Runs all tests from all test files and generates the test result output.

    .NOTES
        This function requires the Pester module to be installed.

    #>

    Param(
        [Parameter(Mandatory)][string] $TestFile,
        [string] $TestName
    )

    $testPath = "C:\image\tests\${TestFile}.Tests.ps1"
    if (-not (Test-Path $testPath)) {
        throw "Unable to find test file '$TestFile' on '$testPath'."
    }

    $configuration = [PesterConfiguration] @{
        Run    = @{ Path = $testPath; PassThru = $true }
        Output = @{ Verbosity = "Detailed"; RenderMode = "Plaintext" }
    }
    if ($TestName) {
        $configuration.Filter.FullName = $TestName
    }
    if ($TestFile -eq "*") {
        $configuration.TestResult.Enabled = $true
        $configuration.TestResult.OutputPath = "C:\image\tests\testResults.xml"
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
        [string] $Because
    )

    $outputLines = (& $env:comspec /c "$ActualValue 2>&1") -as [string[]]
    $exitCode = $LASTEXITCODE

    [bool] $succeeded = $exitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
        $commandOutputIndent = " " * 4
        $commandOutput = ($outputLines | ForEach-Object { "${commandOutputIndent}${_}" }) -join "`n"
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${exitCode} and output:`n${commandOutput}"
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
        [String] $ActualValue,
        [String] $RegularExpression,
        [switch] $Negate
    )

    [string] $output = (& $env:comspec /c "$ActualValue 2>&1")
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

function Get-ModuleVersionAsJob {
    Param (
        [Parameter(Mandatory)]
        [String] $modulePath,
        [Parameter(Mandatory)]
        [String] $moduleName
    )
    # Script block to run commands in separate PowerShell environment
    $testJob = Start-Job -ScriptBlock {
        param (
            $modulePath,
            $moduleName
        )
        # Disable warning messages to prevent additional warnings about Az and Azurerm modules in the same session
        $WarningPreference = "SilentlyContinue"
        $env:PsModulePath = "$modulePath;$env:PsModulePath"
        Import-Module -Name $moduleName
        (Get-Module -Name $moduleName).Version.ToString()

    } -ArgumentList $modulePath, $moduleName

    $testJob | Wait-Job | Receive-Job | Out-File -FilePath "${env:TEMP}\module-version.txt"
    Remove-Job $testJob
}

Export-ModuleMember -Function @(
    'Get-EnvironmentVariable'
    'Invoke-PesterTests'
    'Get-ModuleVersionAsJob'
)

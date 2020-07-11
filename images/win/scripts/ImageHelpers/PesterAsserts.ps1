# Pester Assert to check exit code of command
function ShouldReturnZeroExitCode {
    Param(
        [String] $ActualValue,
        [switch] $Negate,
        [string] $Because
    )

    $result = Get-CommandResult $ActualValue

    [bool]$succeeded = $result.ExitCode -eq 0
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded)
    {
        $сommandOutputIndent = " " * 4
        $commandOutput = ($result.Output | ForEach-Object { "${сommandOutputIndent}${_}" }) -join "`n"
        $failureMessage = "Command '${ActualValue}' has finished with exit code ${actualExitCode}`n${commandOutput}"
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

# Pester Assert to check if string starts with
function ShouldStartsWith {
    Param(
        [String] $ActualValue,
        [String] $ExpectedValue,
        [switch] $Negate,
        [string] $Because
    )

    [bool] $succeeded = $false
    if ($ActualValue -and ($ActualValue.GetType().Name -eq "String")) {
        $succeeded = $ActualValue.StartsWith($ExpectedValue)
    }

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded)
    {
        if ($Negate) {
            $failureMessage = "Expected '${ActualValue}' to not start with '${ExpectedValue}' but it did start"
        } else {
            $failureMessage = "Expected '${ActualValue}' to start with '${ExpectedValue}' but it did not start"
        }
    }

    return [PSCustomObject] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

If (Get-Command -Name Add-AssertionOperator -ErrorAction SilentlyContinue) {
    Add-AssertionOperator -Name ReturnZeroExitCode -InternalName ShouldReturnZeroExitCode -Test ${function:ShouldReturnZeroExitCode}
    Add-AssertionOperator -Name StartsWith -InternalName ShouldStartsWith -Test ${function:ShouldStartsWith}
}
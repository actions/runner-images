function ShouldBeArray([Array] $ActualValue, [Array]$ExpectedValue, [Switch] $Negate, [String] $Because) {
    if ($Negate) {
        throw "Negation is not supported for Should-BeArray"
    }

    if ($ExpectedValue.Count -eq 0) {
        throw "Expected array cannot be empty. Use Should-BeNullOrEmpty instead."
    }

    $ExpectedValue | ForEach-Object {
        if ($_.GetType() -notin @([String], [Int32])) {
            throw "Only string or int arrays are supported in Should-BeArray"
        }
    }

    $actualValueJson = $ActualValue | ConvertTo-Json
    $expectedValueJson = $ExpectedValue | ConvertTo-Json

    $succeeded = ($ActualValue.Count -eq $ExpectedValue.Count) -and ($actualValueJson -eq $expectedValueJson)

    if (-not $succeeded) {
        $failureMessage = "Expected array '$actualValueJson' to be equal to '$expectedValueJson'"
    }

    return [PSCustomObject]@{
        Succeeded = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-ShouldOperator -Name BeArray `
    -InternalName 'ShouldBeArray' `
    -Test ${function:ShouldBeArray} `
    -SupportsArrayInput
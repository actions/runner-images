function Get-SystemVariable {
    [CmdletBinding()]
    param(
        [string]$SystemVariable
    )
    return [System.Environment]::GetEnvironmentVariable($SystemVariable, "Machine")
}

function Set-SystemVariable {
    [CmdletBinding()]
    param(
        [string]$SystemVariable,
        [string]$Value
    )
    [System.Environment]::SetEnvironmentVariable($SystemVariable, $Value, "Machine")
    return Get-SystemVariable $SystemVariable
}

function Get-MachinePath {
    [CmdletBinding()]
    param(

    )
    return Get-SystemVariable PATH
}

function Set-MachinePath {
    [CmdletBinding()]
    param(
        [string]$NewPath
    )
    Set-SystemVariable PATH $NewPath
}

function Test-MachinePath {
    [CmdletBinding()]
    param(
        [string]$PathItem
    )

    $pathItems = (Get-MachinePath).Split(';')

    return $pathItems.Contains($PathItem)
}

function Add-MachinePathItem {
    param(
        [string]$PathItem
    )

    $currentPath = Get-MachinePath
    $newPath = $PathItem + ';' + $currentPath
    Set-MachinePath -NewPath $newPath
}

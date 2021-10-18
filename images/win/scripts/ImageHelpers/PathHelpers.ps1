function Get-SystemVariable {
    param(
        [string]$SystemVariable
    )
    
    [System.Environment]::GetEnvironmentVariable($SystemVariable, "Machine")
}

function Set-SystemVariable {
    param(
        [string]$SystemVariable,
        [string]$Value
    )
    
    [System.Environment]::SetEnvironmentVariable($SystemVariable, $Value, "Machine")
    Get-SystemVariable $SystemVariable
}

function Get-MachinePath {
    Get-SystemVariable PATH
}

function Set-MachinePath {
    param(
        [string]$NewPath
    )
    
    Set-SystemVariable PATH $NewPath
}

function Test-MachinePath {
    param(
        [string]$PathItem
    )

    $pathItems = (Get-MachinePath).Split(';')
    $pathItems.Contains($PathItem)
}

function Add-MachinePathItem {
    param(
        [string]$PathItem
    )

    $currentPath = Get-MachinePath
    $newPath = $PathItem + ';' + $currentPath
    Set-MachinePath -NewPath $newPath
}

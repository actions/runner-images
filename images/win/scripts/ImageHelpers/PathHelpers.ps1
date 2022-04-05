function Connect-Hive {
    param(
        [string]$FileName = "C:\Users\Default\NTUSER.DAT",
        [string]$SubKey = "HKLM\DEFAULT"
    )

    Write-Host "Loading the file $FileName to the Key $SubKey"
    if (Test-Path $SubKey.Replace("\",":")) {
        return
    }

    $result = reg load $SubKey $FileName *>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to load hive: $result"
        exit 1
    }
}

function Disconnect-Hive {
    param(
        [string]$SubKey = "HKLM\DEFAULT"
    )

    Write-Host "Unloading the hive $SubKey"
    if (-not (Test-Path $SubKey.Replace("\",":"))) {
        return
    }

    $result = reg unload $SubKey *>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to unload hive: $result"
        exit 1
    }
}

function Get-SystemVariable {
    param(
        [string]$SystemVariable
    )
    
    [System.Environment]::GetEnvironmentVariable($SystemVariable, "Machine")
}

function Get-DefaultVariable {
    param(
        [string]$DefaultVariable,
        [string]$Name = "DEFAULT\Environment",
        [bool]$Writable = $false
    )

    $key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($Name, $Writable)
    $key.GetValue($DefaultVariable, "", "DoNotExpandEnvironmentNames")
    $key.Handle.Close()
    [System.GC]::Collect()
}

function Set-SystemVariable {
    param(
        [string]$SystemVariable,
        [string]$Value
    )
    
    [System.Environment]::SetEnvironmentVariable($SystemVariable, $Value, "Machine")
    Get-SystemVariable $SystemVariable
}

function Set-DefaultVariable {
    param(
        [string]$DefaultVariable,
        [string]$Value,
        [string]$Name = "DEFAULT\Environment",
        [string]$Kind = "ExpandString",
        [bool]$Writable = $true
    )

    $key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($Name, $Writable)
    $key.SetValue($DefaultVariable, $Value, $Kind)
    Get-DefaultVariable $DefaultVariable
    $key.Handle.Close()
    [System.GC]::Collect()
}

function Get-MachinePath {
    Get-SystemVariable PATH
}

function Get-DefaultPath {
    Get-DefaultVariable Path
}

function Set-MachinePath {
    param(
        [string]$NewPath
    )
    
    Set-SystemVariable PATH $NewPath
}

function Set-DefaultPath {
    param(
        [string]$NewPath
    )

    Set-DefaultVariable PATH $NewPath
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

function Add-DefaultPathItem {
    param(
        [string]$PathItem
    )

    Connect-Hive
    $currentPath = Get-DefaultPath
    $newPath = $PathItem + ';' + $currentPath
    Set-DefaultPath -NewPath $newPath
    Disconnect-Hive
}

function New-ItemPath {
    param (
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force -ErrorAction Ignore | Out-Null
    }
}

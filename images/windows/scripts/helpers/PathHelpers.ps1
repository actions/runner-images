
function Mount-RegistryHive {
    <#
    .SYNOPSIS
        Mounts a registry hive from a file.

    .DESCRIPTION
        The Mount-RegistryHive function loads a registry hive from a specified file into a specified subkey.

    .PARAMETER FileName
        The path to the file from which to load the registry hive.

    .PARAMETER SubKey
        The registry subkey into which to load the hive.

    .EXAMPLE
        Mount-RegistryHive -FileName "C:\Path\To\HiveFile.hiv" -SubKey "HKLM\SubKey"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [Parameter(Mandatory = $true)]
        [string]$SubKey
    )

    Write-Host "Loading the file $FileName to the Key $SubKey"
    if (Test-Path $SubKey.Replace("\", ":")) {
        Write-Warning "The key $SubKey is already loaded"
        return
    }

    $result = reg load $SubKey $FileName *>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to load file $FileName to the key ${SubKey}: $result"
        exit 1
    }
}

function Dismount-RegistryHive {
    <#
    .SYNOPSIS
        Dismounts a registry hive.

    .DESCRIPTION
        The Dismount-RegistryHive function unloads a registry hive from a specified subkey.

    .PARAMETER SubKey
        The registry subkey from which to unload the hive.

    .EXAMPLE
        Dismount-RegistryHive -SubKey "HKLM\SubKey"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$SubKey
    )

    Write-Host "Unloading the hive $SubKey"
    if (-not (Test-Path $SubKey.Replace("\", ":"))) {
        return
    }

    $result = reg unload $SubKey *>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to unload hive: $result"
        exit 1
    }
}

function Add-MachinePathItem {
    param(
        [string]$PathItem
    )

    $currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $newPath = $PathItem + ';' + $currentPath
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
}

function Add-DefaultPathItem {
    param(
        [Parameter(Mandatory = $true)]
        [string]$PathItem
    )

    Mount-RegistryHive `
        -FileName "C:\Users\Default\NTUSER.DAT" `
        -SubKey "HKLM\DEFAULT"

    $key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey("DEFAULT\Environment", $true)
    $currentValue = $key.GetValue("Path", "", "DoNotExpandEnvironmentNames")
    $updatedValue = $PathItem + ';' + $currentValue
    $key.SetValue("Path", $updatedValue, "ExpandString")
    $key.Handle.Close()
    [System.GC]::Collect()

    Dismount-RegistryHive "HKLM\DEFAULT"
}

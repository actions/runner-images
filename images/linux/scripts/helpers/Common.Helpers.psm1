function Get-CommandResult {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [switch] $Multiline
    )
    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $stdout = & bash -c "$Command 2>&1"
    $exitCode = $LASTEXITCODE
    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

function Get-OSName {
    lsb_release -ds
}

function Get-KernelVersion {
    $kernelVersion = uname -r
    return "Linux kernel version: $kernelVersion"
}

function Test-IsUbuntu16 {
    return (lsb_release -rs) -eq "16.04"
}

function Test-IsUbuntu18 {
    return (lsb_release -rs) -eq "18.04"
}

function Test-IsUbuntu20 {
    return (lsb_release -rs) -eq "20.04"
}

function Get-ToolsetContent {
    $toolset = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    Get-Content $toolset -Raw | ConvertFrom-Json
}

function Get-ToolsetValue {
    param (
        [Parameter(Mandatory = $true)]
        [string] $KeyPath
    )

    $jsonNode = Get-ToolsetContent

    $pathParts = $KeyPath.Split(".")
    # try to walk through all arguments consequentially to resolve specific json node
    $pathParts | ForEach-Object {
        $jsonNode = $jsonNode.$_
    }
    return $jsonNode
}

function Get-AndroidPackages {
    $androidSDKManagerPath = "/usr/local/lib/android/sdk/cmdline-tools/latest/bin/sdkmanager"
    $androidPackages = & $androidSDKManagerPath --list --verbose
    return $androidPackages
}

function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}
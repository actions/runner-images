function Get-CommandResult {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [int[]] $ExpectExitCode = 0,
        [switch] $Multiline,
        [bool] $ValidateExitCode = $true
    )

    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $stdout = & bash -c "$Command 2>&1"
    $exitCode = $LASTEXITCODE

    if ($ValidateExitCode) {
        if ($ExpectExitCode -notcontains $exitCode) {
            try {
                throw "StdOut: '$stdout' ExitCode: '$exitCode'"
            } catch {
                Write-Host $_.Exception.Message
                Write-Host $_.ScriptStackTrace
                exit $LASTEXITCODE
            }
        }
    }

    return @{
        Output = If ($Multiline -eq $true) { $stdout } else { [string]$stdout }
        ExitCode = $exitCode
    }
}

function Get-OSVersionShort {
    $(Get-OSVersionFull) | Take-OutputPart -Delimiter '.' -Part 0,1
}

function Get-OSVersionFull {
    lsb_release -ds | Take-OutputPart -Part 1, 2
}

function Get-KernelVersion {
    $kernelVersion = uname -r
    return $kernelVersion
}

function Test-IsUbuntu18 {
    return (lsb_release -rs) -eq "18.04"
}

function Test-IsUbuntu20 {
    return (lsb_release -rs) -eq "20.04"
}

function Test-IsUbuntu22 {
    return (lsb_release -rs) -eq "22.04"
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
    $androidPackages = & $androidSDKManagerPath --list --verbose 2>&1
    return $androidPackages
}

function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}
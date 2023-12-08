function Get-CommandResult {
    <#
    .SYNOPSIS
        Runs a command in bash and returns the output and exit code.

    .DESCRIPTION
        Function runs a provided command in bash and returns the output and exit code as hashtable.

    .PARAMETER Command
        The command to run.

    .PARAMETER ExpectedExitCode
        The expected exit code. If the actual exit code does not match, an exception is thrown.

    .PARAMETER Multiline
        If true, the output is returned as an array of strings. Otherwise, the output is returned as a single string.

    .PARAMETER ValidateExitCode
        If true, the actual exit code is compared to the expected exit code.

    .EXAMPLE
        $result = Get-CommandResult "ls -la"

        This command runs "ls -la" in bash and returns the output and exit code as hashtable.

    #>
    param (
        [Parameter(Mandatory=$true)]
        [string] $Command,
        [int[]] $ExpectedExitCode = 0,
        [switch] $Multiline,
        [bool] $ValidateExitCode = $true
    )

    # Bash trick to suppress and show error output because some commands write to stderr (for example, "python --version")
    $stdout = & bash -c "$Command 2>&1"
    $exitCode = $LASTEXITCODE

    if ($ValidateExitCode) {
        if ($ExpectedExitCode -notcontains $exitCode) {
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
        Output = If ($Multiline -eq $true) { $stdout } else { [string] $stdout }
        ExitCode = $exitCode
    }
}

function Test-IsUbuntu20 {
    return (lsb_release -rs) -eq "20.04"
}

function Test-IsUbuntu22 {
    return (lsb_release -rs) -eq "22.04"
}

function Get-ToolsetContent {
    <#
    .SYNOPSIS
        Retrieves the content of the toolset.json file.

    .DESCRIPTION
        This function reads the toolset.json in path provided by INSTALLER_SCRIPT_FOLDER
        environment variable and returns the content as a PowerShell object.
    #>

    $toolsetPath = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    $toolsetJson = Get-Content -Path $toolsetPath -Raw
    ConvertFrom-Json -InputObject $toolsetJson
}

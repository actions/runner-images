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
    $toolset = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    Get-Content $toolset -Raw | ConvertFrom-Json
}

function Get-ToolsetValue {
    <#
    .SYNOPSIS
        This function retrieves the value of a specific toolset.

    .DESCRIPTION
        The Get-ToolsetValue is used to retrieve the value of a specific toolset.
        The toolset is a collection of tools or settings in json format.

    .PARAMETER KeyPath
        The path to the toolset value in json notation.

    .EXAMPLE
        Get-ToolsetValue -Toolset "tool.arch.versions"

        This command returns the value of the nodes named "tool", "arch" and "versions" as PSCustomObject.

    #>
    param (
        [Parameter(Mandatory = $true)]
        [string] $KeyPath
    )

    $jsonNode = Get-ToolsetContent

    $pathParts = $KeyPath.Split(".")
    # walk through all arguments consequentially to resolve specific json node
    $pathParts | ForEach-Object {
        $jsonNode = $jsonNode.$_
    }
    return $jsonNode
}

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
    param(
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

function Test-IsUbuntu24 {
    return (lsb_release -rs) -eq "24.04"
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

function Invoke-DownloadWithRetry {
    <#
    .SYNOPSIS
        Downloads a file from a given URL with retry functionality.

    .DESCRIPTION
        The Invoke-DownloadWithRetry function downloads a file from the specified URL
        to the specified path. It includes retry functionality in case the download fails.

    .PARAMETER Url
        The URL of the file to download.

    .PARAMETER Path
        The path where the downloaded file will be saved. If not provided, a temporary path
        will be used.

    .EXAMPLE
        Invoke-DownloadWithRetry -Url "https://example.com/file.zip" -Path "/usr/local/bin"
        Downloads the file from the specified URL and saves it to the specified path.

    .EXAMPLE
        Invoke-DownloadWithRetry -Url "https://example.com/file.zip"
        Downloads the file from the specified URL and saves it to a temporary path.

    .OUTPUTS
        The path where the downloaded file is saved.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $Url,
        [Alias("Destination")]
        [string] $DestinationPath
    )

    if (-not $DestinationPath) {
        $invalidChars = [IO.Path]::GetInvalidFileNameChars() -join ''
        $re = "[{0}]" -f [RegEx]::Escape($invalidChars)
        $fileName = [IO.Path]::GetFileName($Url) -replace $re

        if ([String]::IsNullOrEmpty($fileName)) {
            $fileName = [System.IO.Path]::GetRandomFileName()
        }
        $DestinationPath = Join-Path -Path "/tmp" -ChildPath $fileName
    }

    Write-Host "Downloading package from $Url to $DestinationPath..."

    $interval = 30
    $downloadStartTime = Get-Date
    for ($retries = 20; $retries -gt 0; $retries--) {
        try {
            $attemptStartTime = Get-Date
            (New-Object System.Net.WebClient).DownloadFile($Url, $DestinationPath)
            $attemptSeconds = [math]::Round(($(Get-Date) - $attemptStartTime).TotalSeconds, 2)
            Write-Host "Package downloaded in $attemptSeconds seconds"
            break
        } catch {
            $attemptSeconds = [math]::Round(($(Get-Date) - $attemptStartTime).TotalSeconds, 2)
            Write-Warning "Package download failed in $attemptSeconds seconds"
            Write-Warning $_.Exception.Message
        }

        if ($retries -eq 0) {
            $totalSeconds = [math]::Round(($(Get-Date) - $downloadStartTime).TotalSeconds, 2)
            throw "Package download failed after $totalSeconds seconds"
        }

        Write-Warning "Waiting $interval seconds before retrying (retries left: $retries)..."
        Start-Sleep -Seconds $interval
    }

    return $DestinationPath
}

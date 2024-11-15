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

# Gets path to the tool, analogue of 'which tool'
function Get-ToolPath($tool) {
    return (Get-Command $tool).Path
}

# Returns the object with information about current OS
# It can be used for OS-specific tests
function Get-OSVersion {
    $osVersion = [Environment]::OSVersion
    $processorArchitecture = arch

    return [PSCustomObject]@{
        Version        = $osVersion.Version
        Platform       = $osVersion.Platform
        IsArm64        = $processorArchitecture -eq "arm64"
        IsMonterey     = $osVersion.Version.Major -eq "12"
        IsVentura      = $($osVersion.Version.Major -eq "13")
        IsVenturaArm64 = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -eq "arm64")
        IsVenturaX64   = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -ne "arm64")
        IsSonoma       = $($osVersion.Version.Major -eq "14")
        IsSonomaArm64  = $($osVersion.Version.Major -eq "14" -and $processorArchitecture -eq "arm64")
        IsSonomaX64    = $($osVersion.Version.Major -eq "14" -and $processorArchitecture -ne "arm64")
        IsSequoia       = $($osVersion.Version.Major -eq "15")
        IsSequoiaArm64  = $($osVersion.Version.Major -eq "15" -and $processorArchitecture -eq "arm64")
        IsSequoiaX64    = $($osVersion.Version.Major -eq "15" -and $processorArchitecture -ne "arm64")
    }
}

function Get-ToolsetContent {
    <#
    .SYNOPSIS
        Retrieves the content of the toolset.json file.

    .DESCRIPTION
        This function reads the toolset.json in path provided by IMAGE_FOLDER
        environment variable and returns the content as a PowerShell object.
    #>

    $toolsetPath = Join-Path $env:IMAGE_FOLDER "toolset.json"
    $toolsetJson = Get-Content -Path $toolsetPath -Raw
    ConvertFrom-Json -InputObject $toolsetJson
}

function Invoke-DownloadWithRetry {
    Param
    (
        [Parameter(Mandatory)]
        [string] $Url,
        [Alias("Destination")]
        [string] $Path
    )

    if (-not $Path) {
        $invalidChars = [IO.Path]::GetInvalidFileNameChars() -join ''
        $re = "[{0}]" -f [RegEx]::Escape($invalidChars)
        $fileName = [IO.Path]::GetFileName($Url) -replace $re

        if ([String]::IsNullOrEmpty($fileName)) {
            $fileName = [System.IO.Path]::GetRandomFileName()
        }
        $Path = Join-Path -Path "/tmp" -ChildPath $fileName
    }

    Write-Host "Downloading package from $Url to $Path..."

    $interval = 30
    $downloadStartTime = Get-Date
    for ($retries = 20; $retries -gt 0; $retries--) {
        try {
            $attemptStartTime = Get-Date
            (New-Object System.Net.WebClient).DownloadFile($Url, $Path)
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

    return $Path
}

function Get-Architecture {
    $arch = arch
    if ($arch -ne "arm64") {
        $arch = "x64"
    }

    return $arch
}

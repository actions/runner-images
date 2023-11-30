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
function Get-WhichTool($tool) {
    return (Get-Command $tool).Path
}

# Gets value of environment variable by the name
function Get-EnvironmentVariable($variable) {
    return [System.Environment]::GetEnvironmentVariable($variable)
}

# Returns the object with information about current OS
# It can be used for OS-specific tests
function Get-OSVersion {
    $osVersion = [Environment]::OSVersion
    $osVersionMajorMinor = $osVersion.Version.ToString(2)
    $processorArchitecture = arch
    return [PSCustomObject]@{
        Version        = $osVersion.Version
        Platform       = $osVersion.Platform
        IsArm64        = $processorArchitecture -eq "arm64"
        IsBigSur       = $osVersion.Version.Major -eq "11"
        IsMonterey     = $osVersion.Version.Major -eq "12"
        IsVentura      = $($osVersion.Version.Major -eq "13")
        IsVenturaArm64 = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -eq "arm64")
        IsVenturaX64   = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -ne "arm64")
        IsSonoma       = $($osVersion.Version.Major -eq "14")
        IsSonomaArm64  = $($osVersion.Version.Major -eq "14" -and $processorArchitecture -eq "arm64")
        IsSonomaX64    = $($osVersion.Version.Major -eq "14" -and $processorArchitecture -ne "arm64")
    }
}

function Get-ChildItemWithoutSymlinks {
    param (
        [Parameter(Mandatory)]
        [string] $Path,
        [string] $Filter
    )

    $files = Get-ChildItem -Path $Path -Filter $Filter
    $files = $files | Where-Object { !$_.LinkType } # cut symlinks
    return $files
}

# Get the value of specific toolset node
# Example, invoke `Get-ToolsetValue "xamarin.bundles"` to get value of `$toolsetJson.xamarin.bundles`
function Get-ToolsetValue {
    param (
        [Parameter(Mandatory = $true)]
        [string] $KeyPath
    )
    $toolsetPath = Join-Path $env:HOME "image-generation" "toolset.json"
    $jsonNode = Get-Content -Raw $toolsetPath | ConvertFrom-Json

    $pathParts = $KeyPath.Split(".")
    # try to walk through all arguments consequentially to resolve specific json node
    $pathParts | ForEach-Object {
        $jsonNode = $jsonNode.$_
    }
    return $jsonNode
}

function Get-ToolcachePackages {
    $toolcachePath = Join-Path $env:HOME "image-generation" "toolcache.json"
    return Get-Content -Raw $toolcachePath | ConvertFrom-Json
}

function Invoke-RestMethodWithRetry {
    param (
        [Parameter()]
        [string]
        $Url
    )
    Invoke-RestMethod $Url -MaximumRetryCount 10 -RetryIntervalSec 30
}

function Invoke-ValidateCommand {
    param(
        [Parameter(Mandatory)]
        [string]$Command,
        [Uint] $Timeout = 0
    )

    if ($Timeout -eq 0)
    {
        $output = Invoke-Expression -Command $Command
        if ($LASTEXITCODE -ne 0) {
            throw "Command '$Command' has finished with exit code $LASTEXITCODE"
        }
        return $output
    }
    else
    {
        $job = $command | Start-Job -ScriptBlock {
            $output = Invoke-Expression -Command $input
            if ($LASTEXITCODE -ne 0) {
                  throw 'Command failed'
            }
            return $output
        }
        $waitObject = $job | Wait-Job -Timeout $Timeout
        if(-not $waitObject)
        {
             throw "Command '$Command' has timed out"
        }
        if($waitObject.State -eq 'Failed')
        {
             throw "Command '$Command' has failed"
        }
        Receive-Job -Job $job
    }
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

function Add-EnvironmentVariable {
    param
    (
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Value,
        [string] $FilePath = "${env:HOME}/.bashrc"
    )

    $envVar = "export {0}={1}" -f $Name, $Value
    Add-Content -Path $FilePath -Value $envVar
}

function isVeertu {
    return (Test-Path -Path "/Library/Application Support/Veertu")
}

function Get-Architecture {
    $arch = arch
    if ($arch -ne "arm64")
    {
        $arch = "x64"
    }

    return $arch
}

function Test-CommandExists {
    param
    (
        [Parameter(Mandatory)] [string] $Command
    )

    [boolean] (Get-Command $Command  -ErrorAction 'SilentlyContinue')
}

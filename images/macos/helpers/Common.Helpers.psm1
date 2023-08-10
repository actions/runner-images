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
        Version = $osVersion.Version
        Platform = $osVersion.Platform
        IsBigSur = $osVersion.Version.Major -eq "11"
        IsMonterey = $osVersion.Version.Major -eq "12"
        IsVentura = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -ne "arm64")
        IsVenturaArm64 = $($osVersion.Version.Major -eq "13" -and $processorArchitecture -eq "arm64")
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
        [string]$Command
    )

    $output = Invoke-Expression -Command $Command
    if ($LASTEXITCODE -ne 0) {
        throw "Command '$Command' has finished with exit code $LASTEXITCODE"
    }
    return $output
}

function Start-DownloadWithRetry {
    Param
    (
        [Parameter(Mandatory)]
        [string] $Url,
        [string] $Name,
        [string] $DownloadPath = "${env:Temp}",
        [int] $Retries = 20,
        [int] $Interval = 30
    )

    if ([String]::IsNullOrEmpty($Name)) {
        $Name = [IO.Path]::GetFileName($Url)
    }

    $filePath = Join-Path -Path $DownloadPath -ChildPath $Name

    #Default retry logic for the package.
    while ($Retries -gt 0)
    {
        try
        {
            Write-Host "Downloading package from: $Url to path $filePath ."
            (New-Object System.Net.WebClient).DownloadFile($Url, $filePath)
            break
        }
        catch
        {
            Write-Host "There is an error during package downloading:`n $_"
            $Retries--

            if ($Retries -eq 0)
            {
                Write-Host "File can't be downloaded. Please try later or check that file exists by url: $Url"
                exit 1
            }

            Write-Host "Waiting $Interval seconds before retrying. Retries left: $Retries"
            Start-Sleep -Seconds $Interval
        }
    }

    return $filePath
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

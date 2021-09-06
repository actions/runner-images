[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [Version] $MacOSVersion,
    [ValidateNotNullOrEmpty()]
    [String] $TemplateUsername,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String] $TemplatePassword,
    [ValidateNotNullOrEmpty()]
    [String] $RegistryUrl,
    [Bool] $BetaSearch = $false,
    [Int] $CpuCount = 6,
    [Int] $RamSizeGb = 7,
    [Int] $DiskSizeGb = 300,
    [String] $DisplayResolution = "1920x1080"
)

$ErrorActionPreference = "Stop"

function Get-MacOSInstaller {
    param (
        [Version] $MacOSVersion,
        [Bool] $BetaSearch = $false
    )

    # Enroll machine to DeveloperSeed if we need beta and unenroll otherwise
    if ($BetaSearch)
    {
        Write-Host "Beta Version requested. Enrolling machine to DeveloperSeed"
        sudo /System/Library/PrivateFrameworks/Seeding.framework/Versions/Current/Resources/seedutil enroll DeveloperSeed | Out-Null
    }
    else
    {
        Write-Host "Reseting the seed before requesting stable versions"
        sudo /System/Library/PrivateFrameworks/Seeding.framework/Versions/Current/Resources/seedutil unenroll | Out-Null
    }

    $availableVersions = Get-AvailableVersions -IsBeta $BetaSearch

    if (-not ($MacOSVersion -in $availableVersions.OsVersion))
    {
        Write-Host "Requested macOS version '$MacOSVersion' not found in the list of avaialable installers. Avaialable versions are:`n$($availableVersions.OsVersion)"
        Write-Host 'Make sure to pass "-BetaSearch $true" if you need a beta version installer'
        exit 1
    }

    # Validate there is no softwareupdate at the moment
    Test-SoftwareUpdate

    $macOsName = ($availableVersions | Where-Object { $_.OsVersion -match $MacOSVersion }).OsName
    $installerPathPattern = "/Applications/Install*${macOsName}.app"

    if (Test-Path $installerPathPattern) {
        Write-Host "Removing existed macOS $macOsName installation package before downloading the new one"
        bash -c "sudo rm -rf $installerPathPattern"
    }

    Write-Host "Requested macOS version '$MacOSVersion' installer found, fetching it from Apple"
    softwareupdate --fetch-full-installer --full-installer-version $MacOSVersion
    $installerPath = Get-ChildItem -Path $installerPathPattern
    Write-Host "Installer successfully downloaded to '$installerPath'"

    return $installerPath.FullName
}

function Get-AvailableVersions {
    param (
        [Int] $RetryCount = 20,
        [Int] $RetryInterval = 60,
        [Bool] $IsBeta = $false
    )

    if ($IsBeta)
    {
        $searchPostfix = " beta"
    }

    $searchPattern = "macOS (?<osname>[a-zA-z ]*$searchPostfix), Version: (?<osversion>(\d+\.){1,}\d+)"

    while ($RetryCount -ne 0)
    {
    $RetryCount--
    $allVersions = softwareupdate --list-full-installers | Select-String -Pattern $searchPattern -AllMatches | ForEach-Object {
        $osName = ($_.Matches.Groups | Where-Object { $_.Name -eq "osname" }).Value
        $osVersion = ($_.Matches.Groups | Where-Object { $_.Name -eq "osversion" }).Value
        [PSCustomObject]@{
            OsName = $osName
            OsVersion = $osVersion
        }
    } | Sort-Object -Property OsVersion -Unique

    if ($allVersions)
    {
        return $allVersions
    }

    Write-Host "Could not fetch installers list, wait $RetryInterval seconds, $RetryCount attempts left"
    Start-Sleep -Seconds $RetryInterval
    }

    Write-Host "All the attempts exhausted, try again later"
    exit 1
}

function Test-SoftwareUpdate {
    param (
        [String] $UpdateProcessName = "softwareupdate",
        [Int] $RetryCount = 20,
        [Int] $RetryInterval = 60
    )

    while ($RetryCount -ne 0)
    {
        $RetryCount--
        $updateProcess = (Get-Process -Name $UpdateProcessName -ErrorAction SilentlyContinue).id

        if (-not $updateProcess)
        {
            return
        }

        # Workaround to get commandline param as it doesn't work for macOS atm https://github.com/PowerShell/PowerShell/issues/13943
        $processName = ps -o command= $updateProcess
        Write-Host "Another software update process is in place with the following arguments '$processName', wait $RetryInterval seconds, $RetryCount attempts left"
        Start-Sleep -Seconds $RetryInterval
    }

    Write-Host "All the attempts exhausted, try again later"
    exit 1
}

function New-AnkaVMTemplate {
    param (
        [String] $InstallerPath,
        [String] $ShortMacOSVersion,
        [String] $TemplateName,
        [String] $TemplateUsername,
        [String] $TemplatePassword,
        [Int] $CpuCount,
        [Int] $RamSizeGb,
        [Int] $DiskSizeGb,
        [String] $DisplayResolution
    )

    $isTemplateExists = (Invoke-Anka { anka --machine-readable list } | ConvertFrom-Json).body.name -eq $templateName
    if ($isTemplateExists)
    {
        Write-Host "Deleting existed template with name '$templateName' before creating a new one"
        Invoke-Anka { anka delete $templateName --yes }
    }

    Write-Host "Creating Anka VM template with name '$templateName' and user $TemplateUsername"
    $env:ANKA_DEFAULT_USER = $TemplateUsername
    $env:ANKA_DEFAULT_PASSWD = $TemplatePassword
    $env:ANKA_CREATE_SUSPEND = 0
    Invoke-Anka { anka create --cpu-count $CpuCount --ram-size "${RamSizeGb}G" --disk-size "${DiskSizeGb}G" --app $InstallerPath $templateName }

    # Apple Metal is available starting from Big Sur
    if (-not $ShortMacOSVersion.StartsWith("10"))
    {
        Write-Host "Enabling Graphics Acceleration with Apple Metal for $templateName"
        Invoke-Anka { anka modify $templateName set display -c pg }
    }
    Write-Host "Setting screen resolution to $DisplayResolution for $templateName"
    Invoke-Anka { anka modify $templateName set display -r $DisplayResolution }

    return $templateName
}

function Add-AnkaImageToRegistry {
    param (
        [String] $RegistryUrl,
        [String] $ShortMacOSVersion,
        [String] $TemplateName
    )

    Write-Host "Adding Anka remote registry to the list of registries"
    Invoke-Anka { anka registry add ankaregistry $RegistryUrl  }

    Write-Host "Setting up default registry for push"
    Invoke-Anka { anka registry set ankaregistry }

    Write-Host "Pushing clean macOS $ShortMacOSVersion to the $RegistryUrl"
    Invoke-Anka { anka registry push -t $ShortMacOSVersion $TemplateName }
}

function Invoke-Anka {
    param (
        [scriptblock] $Cmd
    )

    & $Cmd
    if ($LASTEXITCODE -ne 0) {
        Write-Error "There is an error during command execution"
        exit 1
    }
}

function Get-ShortMacOSVersion {
    param (
        [Version] $MacOSVersion
    )

    # Take Major.Minor version for macOS 10 (10.14 or 10.15) and Major for all further versions
    if ($MacOSVersion.Major -eq 10)
    {
        $shortMacOSVersion = "$($MacOSVersion.Major).$($MacOSVersion.Minor)"
    }
    else
    {
        $shortMacOSVersion = "$($MacOSVersion.Major)"
    }

    return $shortMacOSVersion
}

$macOSInstaller = (Get-MacOSInstaller -MacOSVersion $MacOSVersion -BetaSearch $BetaSearch)[-1]
$shortMacOSVersion = Get-ShortMacOSVersion -MacOSVersion $MacOSVersion
$templateName = "clean_macos_${ShortMacOSVersion}_${DiskSizeGb}gb"
New-AnkaVMTemplate -InstallerPath $macOSInstaller `
                   -ShortMacOSVersion $shortMacOSVersion `
                   -TemplateName $templateName `
                   -TemplateUsername $TemplateUsername `
                   -TemplatePassword $TemplatePassword `
                   -CpuCount $CpuCount `
                   -RamSizeGb $RamSizeGb `
                   -DiskSizeGb $DiskSizeGb `
                   -DisplayResolution $DisplayResolution

Add-AnkaImageToRegistry -RegistryUrl $registryUrl -ShortMacOSVersion $shortMacOSVersion -TemplateName $templateName
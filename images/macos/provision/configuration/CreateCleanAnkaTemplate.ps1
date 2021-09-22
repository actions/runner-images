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

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String] $RegistryUrl,

    [Bool] $BetaSearch = $false,
    [Int] $CpuCount = 6,
    [Int] $RamSizeGb = 7,
    [Int] $DiskSizeGb = 300,
    [String] $DisplayResolution = "1920x1080"
)

$ErrorActionPreference = "Stop"

function Get-MacOSInstallers {
    param (
        [version] $MacOSVersion,
        [bool] $BetaSearch = $false
    )

    # Enroll machine to DeveloperSeed if we need beta and unenroll otherwise
    $seedutil = "/System/Library/PrivateFrameworks/Seeding.framework/Versions/Current/Resources/seedutil"
    if ($BetaSearch) {
        Write-Host "Beta Version requested. Enrolling machine to DeveloperSeed"
        sudo $seedutil enroll DeveloperSeed | Out-Null
    } else {
        Write-Host "Reseting the seed before requesting stable versions"
        sudo $seedutil unenroll | Out-Null
    }

    # Validate there is no softwareupdate at the moment
    Test-SoftwareUpdate

    # Validate availability OSVersion
    $availableVersions = Get-AvailableVersions -IsBeta $BetaSearch
    $macOSName = $availableVersions.Where{ $_.OSVersion -eq $MacOSVersion }.OSName
    if (-not $macOSName) {
        Write-Host "Requested macOS '$MacOSVersion' version not found in the list of available installers. Available versions are:`n$($availableVersions.OSVersion)"
        Write-Host 'Make sure to pass "-BetaSearch $true" if you need a beta version installer'
        exit 1
    }

    $installerPathPattern = "/Applications/Install*${macOSName}.app"
    if (Test-Path $installerPathPattern) {
        $previousInstallerPath = Get-Item -Path $installerPathPattern
        Write-Host "Removing '$previousInstallerPath' installation app before downloading the new one"
        sudo rm -rf "$previousInstallerPath"
    }

    # Download macOS installer
    Write-Host "Requested macOS '$MacOSVersion' version installer found, fetching it from Apple Software Update"
    $result = Invoke-WithRetry { softwareupdate --fetch-full-installer --full-installer-version $MacOSVersion } {$LASTEXITCODE -eq 0} | Out-String
    if (-not $result.Contains("Install finished successfully")) {
        Write-Host "[Error]: failed to fetch $MacOSVersion macOS '$MacOSVersion' `n$result"
        exit 1
    }

    $installerPath = Get-Item -Path $installerPathPattern
    Write-Host "Installer successfully downloaded to '$installerPath'"

    return $installerPath.FullName
}

function Invoke-WithRetry {
    param(
        [scriptblock] $Command,
        [scriptblock] $BreakCondition,
        [int] $RetryCount = 20,
        [int] $Seconds = 60
    )

    while ($RetryCount -gt 0) {
       $result = & $Command

       if (& $BreakCondition) {
           break
       }

       $RetryCount--
       Write-Host "Waiting $Seconds seconds before retrying. Retries left: $RetryCount"
       Start-Sleep -Seconds $Seconds
    }

    $result
}

function Get-AvailableVersions {
    param (
        [Int] $RetryCount = 20,
        [Int] $RetryInterval = 60,
        [Bool] $IsBeta = $false
    )

    if ($IsBeta) {
        $searchPostfix = " beta"
    }
    
    $softwareUpdates = Invoke-WithRetry { softwareupdate --list-full-installers | Where-Object { $_.Contains("Title: macOS") -and $_ -match $searchPostfix } } { {$LASTEXITCODE -eq 0}}
    $allVersions = $softwareUpdates -replace "(\* )?(Title|Version|Size):" | ConvertFrom-Csv -Header OsName, OsVersion
        
    return $allVersions
}

function Test-SoftwareUpdate {
    param (
        [String] $UpdateProcessName = "softwareupdate",
        [Int] $RetryCount = 20,
        [Int] $RetryInterval = 60
    )

   $command = {
      $updateProcess = (Get-Process -Name $UpdateProcessName -ErrorAction SilentlyContinue).id
      if ($updateProcess) {
          # Workaround to get commandline param as it doesn't work for macOS atm https://github.com/PowerShell/PowerShell/issues/13943
          $processName = ps -o command= $updateProcess
          Write-Host "Another software update process is in place with the following arguments '$processName', wait $RetryInterval seconds, $RetryCount attempts left"
      }
   }
   $condition = {
      $null -eq (Get-Process -Name $UpdateProcessName -ErrorAction SilentlyContinue)
   }

   Invoke-WithRetry -Command $command -BreakCondition $condition
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
    if ($isTemplateExists) {
        Write-Host "Deleting existed template with name '$templateName' before creating a new one"
        Invoke-Anka { anka delete $templateName --yes }
    }

    Write-Host "Creating Anka VM template with name '$TemplateName' and user $TemplateUsername"
    $env:ANKA_DEFAULT_USER = $TemplateUsername
    $env:ANKA_DEFAULT_PASSWD = $TemplatePassword
    $env:ANKA_CREATE_SUSPEND = 0
    Write-Host "Cpu Count: $CpuCount, RamSize: ${RamSizeGb}G, DiskSizeGb: ${DiskSizeGb}G, InstallerPath: $InstallerPath, TemplateName: $templateName"
    Invoke-Anka { anka create --cpu-count $CpuCount --ram-size "${RamSizeGb}G" --disk-size "${DiskSizeGb}G" --app $InstallerPath $templateName }

    # Apple Metal is available starting from Big Sur
    if (-not $ShortMacOSVersion.StartsWith("10.")) {
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

    Write-Host "Pushing image to the registry..."
    Invoke-Anka { anka registry -a $RegistryUrl push -t $ShortMacOSVersion $TemplateName }
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
    if ($MacOSVersion.Major -eq 10) {
        $shortMacOSVersion = $MacOSVersion.ToString(2)
    }
    else {
        $shortMacOSVersion = $MacOSVersion.Major
    }

    return $shortMacOSVersion
}

$macOSInstaller = Get-MacOSInstallers -MacOSVersion $MacOSVersion -BetaSearch $BetaSearch
$shortMacOSVersion = Get-ShortMacOSVersion -MacOSVersion $MacOSVersion
$templateName = "clean_macos_${shortMacOSVersion}_${DiskSizeGb}gb"
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
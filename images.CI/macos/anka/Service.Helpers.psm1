function Enable-AutoLogon {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Password
    )

    $url = "https://raw.githubusercontent.com/actions/runner-images/main/images/macos/provision/bootstrap-provisioner/setAutoLogin.sh"
    $script = Invoke-RestMethod -Uri $url
    $base64 = [Convert]::ToBase64String($script.ToCharArray())
    $command = "echo $base64 | base64 --decode > ./setAutoLogin.sh;sudo bash ./setAutoLogin.sh '${UserName}' '${Password}';rm ./setAutoLogin.sh"
    Invoke-SSHPassCommand -HostName $HostName -Command $command
}

function Invoke-SoftwareUpdateArm64 {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Password
    )

    $url = "https://raw.githubusercontent.com/actions/runner-images/main/images/macos/provision/configuration/auto-software-update-arm64.exp"
    $script = Invoke-RestMethod -Uri $url
    $base64 = [Convert]::ToBase64String($script.ToCharArray())
    $command = "echo $base64 | base64 --decode > ./auto-software-update-arm64.exp;chmod +x ./auto-software-update-arm64.exp; ./auto-software-update-arm64.exp ${Password};rm ./auto-software-update-arm64.exp"
    Invoke-SSHPassCommand -HostName $HostName -Command $command
}

function Get-AvailableVersions {
    param (
        [bool] $IsBeta = $false
    )

    if ($IsBeta) {
        $searchPostfix = " beta"
    }

    $command = { /usr/sbin/softwareupdate --list-full-installers | grep "macOS" }
    $condition = { $LASTEXITCODE -eq 0 }
    $softwareUpdates = Invoke-WithRetry -Command $command -BreakCondition $condition | Where-Object { $_.Contains("Title: macOS") -and $_ -match $searchPostfix }
    $allVersions = $softwareUpdates -replace "(\* )?(Title|Version|Size):" | ConvertFrom-Csv -Header OSName, OSVersion | Select-Object OSName, OSVersion -Unique

    $allVersions
}

function Get-AvailableIPSWVersions {
    param (
        [bool] $IsBeta = $false,
        [bool] $IsLatest = $true,
        [string] $MacOSCodeNameOrVersion
    )

    if ($IsBeta) {
        $command = { mist list installer "$MacOSCodeNameOrVersion" --include-betas --latest --export "/Applications/export.json"}
    } elseif ($IsLatest) {
        $command = { mist list installer "$MacOSCodeNameOrVersion" --latest  --export "/Applications/export.json" }
    } else {
        $command = { mist list installer "$MacOSCodeNameOrVersion"  --export "/Applications/export.json" }
    }

    $condition = { $LASTEXITCODE -eq 0 }
    Invoke-WithRetry -Command $command -BreakCondition $condition | Out-Null
    $softwareList = get-content -Path "/Applications/export.json"
    $turgetVersion = ($softwareList | ConvertFrom-Json).version
    if ($null -eq $turgetVersion) {
        Write-Host "Requested macOS '$MacOSCodeNameOrVersion' version not found in the list of available installers."
        $command = { mist list installer "$($MacOSCodeNameOrVersion.split('.')[0])" }
        Invoke-WithRetry -Command $command -BreakCondition $condition
        exit 1
    }
    return $turgetVersion
}

function Get-MacOSIPSWInstaller {
    param (
        [Parameter(Mandatory)]
        [version] $MacOSVersion,

        [bool] $DownloadLatestVersion = $false,
        [bool] $BetaSearch = $false
    )

    if ($MacOSVersion -eq [version] "12.0") {
        $MacOSName = "macOS Monterey"
    } elseif ($MacOSVersion -eq [version] "13.0") {
        $MacOSName = "macOS Ventura"
    } else {
        $MacOSName = $MacOSVersion.ToString()
    }


    Write-Host "`t[*] Finding available full installers"
    if ($DownloadLatestVersion -eq $true) {
        $targetVersion = Get-AvailableIPSWVersions -IsLatest $true -MacOSCodeNameOrVersion $MacOSName
        Write-host "`t[*] The 'DownloadLatestVersion' flag is set to true. Latest macOS version is '$MacOSName' - '$targetVersion' now"
    } elseif ($BetaSearch -eq $true) {
        $targetVersion = Get-AvailableIPSWVersions -IsBeta $true -MacOSCodeNameOrVersion $MacOSName
        Write-host "`t[*] The 'BetaSearch' flag is set to true. Latestbeta macOS version is '$MacOSName' - '$targetVersion' now"
    } else {
        $targetVersion = Get-AvailableIPSWVersions -MacOSCodeNameOrVersion $MacOSName -IsLatest $false
        Write-host "`t[*] The exact version was specified - '$MacOSName' "
    }

    $installerPathPattern = "/Applications/Install ${macOSName}*.ipsw"
    if (Test-Path $installerPathPattern) {
        $previousInstallerPath = Get-Item -Path $installerPathPattern
        Write-Host "`t[*] Removing '$previousInstallerPath' installation app before downloading the new one"
        sudo rm -rf "$previousInstallerPath"
    }

    # Download macOS installer
    $installerDir = "/Applications/"
    $installerName = "Install ${macOSName}.ipsw"
    Write-Host "`t[*] Requested macOS '$targetVersion' version installer found, fetching it from mist database"
    Invoke-WithRetry { mist download firmware "$targetVersion" --output-directory $installerDir --firmware-name "$installerName" } {$LASTEXITCODE -eq 0} | Out-Null
    if (Test-Path "$installerDir$installerName") {
        $result = "$installerDir$installerName"
    } else {
        Write-host "`t[*] Requested macOS '$targetVersion' version installer failed to download"
        exit 1
    }
    return $result
}
function Get-MacOSInstaller {
    param (
        [Parameter(Mandatory)]
        [version] $MacOSVersion,

        [bool] $DownloadLatestVersion = $false,
        [bool] $BetaSearch = $false
    )

    # Enroll machine to DeveloperSeed if we need beta and unenroll otherwise
    $seedutil = "/System/Library/PrivateFrameworks/Seeding.framework/Versions/Current/Resources/seedutil"
    if ($BetaSearch) {
        Write-Host "`t[*] Beta Version requested. Enrolling machine to DeveloperSeed"
        sudo $seedutil enroll DeveloperSeed | Out-Null
    } else {
        Write-Host "`t[*] Reseting the seed before requesting stable versions"
        sudo $seedutil unenroll | Out-Null
    }

    # Validate there is no softwareupdate at the moment
    Test-SoftwareUpdate

    # Validate availability OSVersion
    Write-Host "`t[*] Finding available full installers"
    $availableVersions = Get-AvailableVersions -IsBeta $BetaSearch
    if ($DownloadLatestVersion) {
        $shortMacOSVersion = Get-ShortMacOSVersion -MacOSVersion $MacOSVersion
        $filterSearch = "${shortMacOSVersion}."
        $filteredVersions = $availableVersions.Where{ $_.OSVersion.StartsWith($filterSearch) }
        if (-not $filteredVersions) {
            Write-Host "`t[x] Failed to find any macOS versions using '$filterSearch' search condition"
            Show-StringWithFormat $availableVersions
            exit 1
        }
        Show-StringWithFormat $filteredVersions
        $osVersions = $filteredVersions.OSVersion | Sort-Object {[version]$_}
        $MacOSVersion = $osVersions | Select-Object -Last 1
        Write-Host "`t[*] The 'DownloadLatestVersion' flag is set. Latest macOS version is '$MacOSVersion' now"
    }

    $macOSName = $availableVersions.Where{ $MacOSVersion -eq $_.OSVersion }.OSName.Split(" ")[1]
    if (-not $macOSName) {
        Write-Host "`t[x] Requested macOS '$MacOSVersion' version not found in the list of available installers. Available versions are:`n$($availableVersions.OSVersion)"
        Write-Host "`t[x] Make sure to pass '-BetaSearch `$true' if you need a beta version installer"
        exit 1
    }

    $installerPathPattern = "/Applications/Install macOS ${macOSName}*.app"
    if (Test-Path $installerPathPattern) {
        $previousInstallerPath = Get-Item -Path $installerPathPattern
        Write-Host "`t[*] Removing '$previousInstallerPath' installation app before downloading the new one"
        sudo rm -rf "$previousInstallerPath"
    }

    # Clear LastRecommendedMajorOSBundleIdentifier to prevent error during fetching updates
    # Install failed with error: Update not found
    Update-SoftwareBundle

    # Download macOS installer
    Write-Host "`t[*] Requested macOS '$MacOSVersion' version installer found, fetching it from Apple Software Update"
    $result = Invoke-WithRetry { /usr/sbin/softwareupdate --fetch-full-installer --full-installer-version $MacOSVersion } {$LASTEXITCODE -eq 0} | Out-String
    if (-not $result.Contains("Install finished successfully")) {
        Write-Host "`t[x] Failed to fetch $MacOSVersion macOS `n$result"
        exit 1
    }

    $installerPath = (Get-Item -Path $installerPathPattern).FullName
    if (-not $installerPath) {
        Write-Host "`t[x] Path not found using '$installerPathPattern'"
        exit 1
    }
    Write-Host "`t[*] Installer successfully downloaded to '$installerPath'"

    $installerPath
}

function Get-ShortMacOSVersion {
    param (
        [Parameter(Mandatory)]
        [version] $MacOSVersion
    )

    # Take Major.Minor version for macOS 10 (10.14 or 10.15) and Major for all further versions
    $MacOSVersion.Major -eq 10 ? $MacOSVersion.ToString(2) : $MacOSVersion.ToString(1)
}

function Get-SoftwareUpdate {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName
    )

    $command = "/usr/sbin/softwareupdate --list"
    $result = Invoke-SSHPassCommand -HostName $HostName -Command $command
    $result | Where-Object { $_ -match "(Label|Title):" } | Out-String
}

function Get-SoftwareUpdateHistory {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName
    )

    $command = "/usr/sbin/softwareupdate --history"
    Invoke-SSHPassCommand -HostName $HostName -Command $command | Out-String
}

function Install-SoftwareUpdate {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,
        [array] $listOfUpdates,
        [string] $Password
    )
    $osVersion = [Environment]::OSVersion
    # If an update is happening on macOS 12 we will use the prepared list of updates, otherwise, we will install all updates.
    if ($osVersion.Version.Major -eq "12") {
        foreach ($update in $listOfUpdates){
            # Filtering updates that contain "Ventura" word
            if ($update -notmatch "Ventura") {
                $command = "sudo /usr/sbin/softwareupdate --restart --verbose --install '$($update.trim())'"
                Invoke-SSHPassCommand -HostName $HostName -Command $command
            }
        }
    } else {
        $osArch = $(arch)
        if ($osArch -eq "arm64") {
            Invoke-SoftwareUpdateArm64 -HostName $HostName -Password $Password
        } else {
            $command = "sudo /usr/sbin/softwareupdate --all --install --restart --verbose"
            Invoke-SSHPassCommand -HostName $HostName -Command $command
        }
    }
}

function Invoke-SSHPassCommand {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Command,

        [int] $ConnectTimeout = 10,
        [int] $ConnectionAttempts = 10,
        [int] $ServerAliveInterval = 30
    )

    $sshArg = @(
        "sshpass"
        "-e"
        "ssh"
        "-o UserKnownHostsFile=/dev/null"
        "-o StrictHostKeyChecking=no"
        "-o ConnectTimeout=$ConnectTimeout"
        "-o ConnectionAttempts=$ConnectionAttempts"
        "-o LogLevel=ERROR"
        "-o ServerAliveInterval=$ServerAliveInterval"
        "${env:SSHUSER}@${HostName}"
    )
    $sshPassOptions = $sshArg -join " "
    bash -c "$sshPassOptions \""$Command\"" 2>&1"
}

function Invoke-WithRetry {
    param(
        [scriptblock] $Command,
        [scriptblock] $BreakCondition,
        [int] $RetryCount = 20,
        [int] $Seconds = 60
    )

    while ($RetryCount -gt 0) {
        if ($Command) {
            $result = & $Command
        }

        if (& $BreakCondition) {
            return $result
        }

        $RetryCount--
        if ($RetryCount -eq 0) {
            Write-Error "No more attempts left: $BreakCondition"
        }
        Write-Host "`t    [/] Waiting $Seconds seconds before retrying. Retries left: $RetryCount"
        Start-Sleep -Seconds $Seconds
    }

    $result
}

function Restart-VMSSH {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName
    )

    $command = "sudo reboot"
    Invoke-SSHPassCommand -HostName $HostName -Command $command
}

function Show-StringWithFormat {
    param(
        [Parameter(ValuefromPipeline)]
        [object] $string
    )

    process {
        ($string | Out-String).Trim().split("`n") | ForEach-Object { Write-Host "`t    $_" }
    }
}

function Remove-CurrentBetaSeed {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName
    )

    $command = "sudo /System/Library/PrivateFrameworks/Seeding.framework/Versions/Current/Resources/seedutil unenroll"
    Invoke-SSHPassCommand -HostName $HostName -Command $command | Out-String
}

function Test-AutoLogon {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserName
    )

    Invoke-WithRetry -BreakCondition {
        # pwsh crashes if it invokes directly
        # https://github.com/dotnet/runtime/issues/59059
        $ankaUser = "" | bash -c "anka run $VMName /usr/bin/id -nu"
        $UserName -eq $ankaUser
    }
}

function Test-SoftwareUpdate {
    param (
        [string] $UpdateProcessName = "softwareupdate"
    )

   $command = {
      $updateProcess = (Get-Process -Name $UpdateProcessName -ErrorAction SilentlyContinue).id
      if ($updateProcess) {
          # Workaround to get commandline param as it doesn't work for macOS atm https://github.com/PowerShell/PowerShell/issues/13943
          $processName = /bin/ps -o command= $updateProcess
          Write-Host "`t[*] Another software update process with '$updateProcess' id is in place with the following arguments '$processName'"
      }
   }
   $condition = {
      $null -eq (Get-Process -Name $UpdateProcessName -ErrorAction SilentlyContinue)
   }

   Invoke-WithRetry -Command $command -BreakCondition $condition
}

function Test-SSHPort {
    param(
        [Parameter(Mandatory)]
        [ipaddress] $IPAddress,

        [int] $Port = 22,
        [int] $Timeout = 2000
    )

    Invoke-WithRetry -Command {$true} -BreakCondition {
        try {
            $client = [System.Net.Sockets.TcpClient]::new()
            $client.ConnectAsync($IPAddress, $Port).Wait($Timeout)
        }
        catch {
            $false
        }
        finally {
            $client.Close()
        }
    }
}

function Wait-LoginWindow {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [int] $RetryCount = 60,
        [int] $Seconds = 60
    )

    $condition = {
        $psCommand = "/bin/ps auxww"
        $lw = "/System/Library/CoreServices/loginwindow.app/Contents/MacOS/loginwindow"
        $ctk = "/System/Library/Frameworks/CryptoTokenKit.framework/ctkahp.bundle/Contents/MacOS/ctkahp"
        $proc = Invoke-SSHPassCommand -HostName $HostName -Command $psCommand | Out-String
        $proc.Contains($lw) -and $proc.Contains($ctk)
    }
    Invoke-WithRetry -RetryCount $RetryCount -Seconds $Seconds -BreakCondition $condition
}

function Update-SoftwareBundle {
    $productVersion = sw_vers -productVersion

    if ( $productVersion.StartsWith('11.') ) {
        sudo rm -rf /Library/Preferences/com.apple.commerce.plist
        sudo /usr/bin/defaults delete /Library/Preferences/com.apple.SoftwareUpdate.plist LastRecommendedMajorOSBundleIdentifier | Out-Null
    }
}

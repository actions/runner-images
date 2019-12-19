################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome
################################################################################
function Stop-SvcWithErrHandling
{
    param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)] [string] $ServiceName
    )

    Begin { 
        Write-Debug "Function [Stop-SvcWithErrHnadlig] is started"; 
    }
    Process {
        $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if(-not $Service) {
            Write-Warning "[!] Service [$ServiceName] is not found";
        }
        else {
            Write-Debug "Try to stop service [$ServiceName]";
            try {
                Stop-Service -Name $ServiceName -Force;
                $Service.WaitForStatus("Stopped", "00:01:00");
                Write-Debug "Service [$ServiceName] has been stoppet successfuly";
            }
            catch {
                Write-Error "[!] Failed to stop service [$ServiceName] with error:"
                $_ | Out-String | Write-Error;
            }
        }
    }
    End {
        Write-Debug "Function [Stop-SvcWithErrHnadlig] is stopped";
    }
}

function Set-SvcWithErrHandling 
{
    param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)] [string] $ServiceName,
        [Parameter(Mandatory)] [hashtable] $Arguments
    )
    Begin { 
        Write-Debug "Function [Set-SvcWithErrHnadlig] is started"; 
    }
    Process {
        $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if(-not $Service) {
            Write-Warning "[!] Service [$ServiceName] is not found";
        }
        try {
           Set-Service $ServiceName @Arguments;
        }
        catch {
            Write-Error "[!] Failed to set service [$ServiceName] arguments with error:"
            $_ | Out-String | Write-Error;
        }
    }
    End {
        Write-Debug "Function [Stop-SvcWithErrHnadlig] is stopped";
    }
}

function New-ItemWithErrHandling {
    param (
        [Parameter(Mandatory)] [hashtable] $Arguments
    )
    Write-Debug "Creation of [$($Arguments.Name)] item";
    try {
        New-ItemProperty @Arguments;
    }
    catch {
        Write-Warning "[!] Failed to create [$($Arguments.Name)] registry parameter";
    }
}

$TempPath = $env:TEMP;
$ChromeInstallerFile = "chrome_installer.exe";
$ChromeInstallerUri = "https://dl.google.com/chrome/install/375.126/chrome_installer.exe";
$IntallationError = $false;

try {
    Write-Debug "Getting the Chrome installer: [$TempPath\$ChromeInstallerFile]";
    Invoke-WebRequest -Uri $ChromeInstallerUri -OutFile "$TempPath\$ChromeInstallerFile";
    
    Write-Debug "Run the Chrome installer."
    Start-Process -FilePath "$TempPath\$ChromeInstallerFile" -ArgumentList "/silent /install" -Wait;
    Write-Debug "Chrome installation complette";
}
catch {
    Write-Error "[!] Failed to install Google Chrome: [$($_.Exception.Message)]";
    $IntallationError = $true;
}
finally{
    Write-Debug "Removing the Chrome installer file."
    Remove-Item "$TempPath\$ChromeInstallerFile" -Force;
}

if($IntallationError) {
    exit;
}
Write-Debug "Adding the firewall rule for Google update blocking";
New-NetFirewallRule -DisplayName "BlockGoogleUpdate" -Direction Outbound -Action Block -Program "C:\Program Files (x86)\Google\Update\GoogleUpdate.exe";

('gupdate','gupdatem') | Stop-SvcWithErrHandling;
('gupdate','gupdatem') | Set-SvcWithErrHandling -Arguments @{StartupType = "Disabled"};

$regGoogleUpdatePath = "HKLM:\SOFTWARE\Policies\Google\Update";
$regGoogleUpdateChrome = "HKLM:\SOFTWARE\Policies\Google\Chrome";
($regGoogleUpdatePath, $regGoogleUpdateChrome) | ForEach-Object {  
    Write-Debug "Creation of [$_] registry key";
    try {
        New-Item -Path $_ -Force;
    }
    catch {
        Write-Warning "[!] Failed to create [$_] registry key";
    } 
}

$regGoogleUpdateParameters = @(
    @{ Name = "AutoUpdateCheckPeriodMinutes"; Value = 00000000},
    @{ Name = "UpdateDefault"; Value = 00000000 },
    @{ Name = "DisableAutoUpdateChecksCheckboxValuet"; Value = 00000000 },
    @{ Name = "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}"; Value = 00000000 }
)

$regGoogleUpdateParameters | ForEach-Object {
    $Arguments = $_;
    $Arguments.Add("Path", $regGoogleUpdatePath);
    $Arguments.Add("Force", $true);
    New-ItemWithErrHandling -Arguments $Arguments
}

$Arguments = @{ Path = $regGoogleUpdateChrome; Name = "AutoUpdateCheckPeriodMinutes"; Value = 00000000; Force = $true };
New-ItemWithErrHandling -Arguments $Arguments;


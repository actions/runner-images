################################################################################
##  File:  Install-BizTalkBuildComponent.ps1
##  Desc:  Install BizTalk Project Build Component
################################################################################

function Install-Msi
{
    <#
    .SYNOPSIS
        A helper function to install executables.

    .DESCRIPTION
        install .exe or .msi binaries from specified Path.

    .PARAMETER MsiPath
        Msi or exe path. Required parameter.

    .PARAMETER LogPath
        The log file path where installation will write log to. Required parameter.

    .EXAMPLE
        Install-Msi -MsiPath "c:\temp\abc.msi" -LogPath "c:\abc.log"
    #>

    Param
    (
        [Parameter(Mandatory)]
        [String] $MsiPath,
        [Parameter(Mandatory)]
        [String] $LogPath
    )

    try
    {
        $filePath = "msiexec.exe"

        Write-Host "Starting Install $MsiPath..."
        $ArgumentList = ('/i', $MsiPath, '/QN', '/norestart', "/l*v",$LogPath)
        $process = Start-Process -FilePath $filePath -ArgumentList $ArgumentList -Wait -PassThru -Verb runAs

        $exitCode = $process.ExitCode
        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host "Installation for $MsiPath is successful."
        }
        else
        {
            Write-Host "Non zero exit code returned by $MsiPath installation process: $exitCode"
            Get-Content  $LogPath | Write-Host
            exit $exitCode
        }
    }
    catch
    {
        Write-Host "Failed to install $MsiPath : $($_.Exception.Message)"
        exit 1
    }
}

$bizTalkBuildComponentUri = "https://aka.ms/BuildComponentSetup.EN"

# Download
Write-Host "BizTalk Project Build Component download..."
$setupZipFile = Start-DownloadWithRetry -Url $bizTalkBuildComponentUri -Name "BuildComponentSetup.EN.zip"

# Unzip
$setupPath = "C:\BizTalkBuildComponent"
if (-not (Test-Path -Path $setupPath)) {
    $null = New-Item -Path $setupPath -ItemType Directory -Force
}

Write-Host "Unzip $setupZipFile to $setupPath..."
Extract-7Zip -Path $setupZipFile -DestinationPath $setupPath
Remove-Item $setupZipFile

# Install
Install-Msi -MsiPath "$setupPath\Bootstrap.msi" -LogPath "$setupPath\bootstrap.log"
Install-Msi -MsiPath "$setupPath\BuildComponentSetup.msi" -LogPath  "$setupPath\buildComponentSetup.log"

Remove-Item $setupPath -Recurse -Force

# Test
Invoke-PesterTests -TestFile "BizTalk" -TestName "BizTalk Build Component Setup"
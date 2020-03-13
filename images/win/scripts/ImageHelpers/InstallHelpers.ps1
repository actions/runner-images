function Install-MSI
{
    Param
    (
        [String]$MsiUrl,
        [String]$MsiName
    )

    $exitCode = -1

    try
    {
        Write-Host "Downloading $MsiName..."
        $FilePath = "${env:Temp}\$MsiName"

        Invoke-WebRequest -Uri $MsiUrl -OutFile $FilePath

        $Arguments = ('/i', $FilePath, '/QN', '/norestart' )

        Write-Host "Starting Install $MsiName..."
        $process = Start-Process -FilePath msiexec.exe -ArgumentList $Arguments -Wait -PassThru
        $exitCode = $process.ExitCode

        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host -Object 'Installation successful'
            return $exitCode
        }
        else
        {
            Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
            exit $exitCode
        }
    }
    catch
    {
        Write-Host -Object "Failed to install the MSI $MsiName"
        Write-Host -Object $_.Exception.Message
        exit -1
    }
}


function Install-EXE
{
    Param
    (
        [String]$Url,
        [String]$Name,
        [String[]]$ArgumentList
    )

    $exitCode = -1

    try
    {
        Write-Host "Downloading $Name..."
        $FilePath = "${env:Temp}\$Name"

        Invoke-WebRequest -Uri $Url -OutFile $FilePath

        Write-Host "Starting Install $Name..."
        $process = Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -Wait -PassThru
        $exitCode = $process.ExitCode

        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host -Object 'Installation successful'
            return $exitCode
        }
        else
        {
            Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
            return $exitCode
        }
    }
    catch
    {
        Write-Host -Object "Failed to install the Executable $Name"
        Write-Host -Object $_.Exception.Message
        return -1
    }
}

function Stop-SvcWithErrHandling
<#
.DESCRIPTION
Function for stopping the Windows Service with error handling

.AUTHOR
Andrey Mishechkin v-andmis@microsoft.com

.PARAMETER -ServiceName
The name of stopping service

.PARAMETER -StopOnError
Switch for stopping the script and exit from PowerShell if one service is absent
#>
{
    param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)] [string] $ServiceName,
        [Parameter()] [switch] $StopOnError
    )

    Process {
        $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if (-not $Service) {
            Write-Warning "[!] Service [$ServiceName] is not found";
            if ($StopOnError) {
                exit 1;
            }
        }
        else {
            Write-Host "Try to stop service [$ServiceName]";
            try {
                Stop-Service -Name $ServiceName -Force;
                $Service.WaitForStatus("Stopped", "00:01:00");
                Write-Host "Service [$ServiceName] has been stopped successfuly";
            }
            catch {
                Write-Error "[!] Failed to stop service [$ServiceName] with error:"
                $_ | Out-String | Write-Error;
            }
        }
    }
}

function Set-SvcWithErrHandling
<#
.DESCRIPTION
Function for setting the Windows Service parameter with error handling

.AUTHOR
Andrey Mishechkin v-andmis@microsoft.com

.PARAMETER -ServiceName
The name of stopping service

.PARAMETER -Arguments
Hashtable for service arguments
#>
{

    param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)] [string] $ServiceName,
        [Parameter(Mandatory)] [hashtable] $Arguments
    )

    Process {
        $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if (-not $Service) {
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
}

function Install-VsixExtension
{
    Param
    (
        [String]$Url,
        [String]$Name
    )

    $FilePath = "${env:Temp}\$Name"
    $retries = 20

    while($retries -gt 0)
    {
        try
        {
            Write-Host "Downloading $Name..."
            (New-Object System.Net.WebClient).DownloadFile($Url, $FilePath)
            break
        }
        catch
        {
            Write-Host "There is an error during $Name downloading"
            $_

            $retries--

            if ($retries -eq 0)
            {
                Write-Host "File can't be downloaded"
                $_
                exit 1
            }

            Write-Host "Waiting 30 seconds before retrying. Retries left: $retries"
            Start-Sleep -Seconds 30
        }
    }

    $ArgumentList = ('/quiet', $FilePath)

    Write-Host "Starting Install $Name..."
    try
    {
        $process = Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\VSIXInstaller.exe" -ArgumentList $ArgumentList -Wait -PassThru
    }
    catch
    {
        Write-Host "There is an error during $Name installation"
        $_
        exit 1
    }

    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 1001) # 1001 means the extension is already installed
    {
        Write-Host "$Name installed successfully"
    }
    else
    {
        Write-Host "Unsuccessful exit code returned by the installation process: $exitCode."
        exit 1
    }

    #Cleanup installation files
    Remove-Item -Force -Confirm:$false $FilePath
}

function Get-VS19ExtensionVersion
{
    param (
        [string] [Parameter(Mandatory=$true)] $packageName
    )

    $instanceFolders = Get-ChildItem -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"

    if ($instanceFolders -is [array])
    {
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path (Join-Path $instanceFolders.FullName '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $packageVersion = ($state.packages | Where-Object { $_.id -eq $packageName }).version

    if (!$packageVersion)
    {
        Write-Host "installed package $packageName for Visual Studio 2019 was not found"
        exit 1
    }

    return $packageVersion
}

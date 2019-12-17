################################################################################
##  File:  Install-Kind.ps1
##  Desc:  Install Kind
################################################################################

$stableKindTag = "v0.5.1"
$tagToUse = $stableKindTag;
$destFilePath = "C:\ProgramData\kind"
$outFilePath = "C:\ProgramData\kind\kind.exe"

try
{
    $getkindUri =  "https://github.com/kubernetes-sigs/kind/releases/download/$tagToUse/kind-windows-amd64"
    Write-Host "Downloading kind.exe..."
    New-Item -Path $destFilePath -ItemType Directory -Force

    Invoke-WebRequest -Uri $getkindUri -OutFile $outFilePath

    Write-Host "Starting Install kind.exe..."
    $process = Start-Process -FilePath $outFilePath -Wait -PassThru
    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 3010)
    {
        Write-Host -Object 'Installation successful'
        Add-MachinePathItem $destFilePath
        exit $exitCode
    }
    else
    {
        Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
        exit $exitCode
    }
}
catch
{
    Write-Host -Object "Failed to install the Executable kind.exe"
    Write-Host -Object $_.Exception.Message
    exit -1
}

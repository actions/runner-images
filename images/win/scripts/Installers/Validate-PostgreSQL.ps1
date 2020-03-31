function Stop-PostgreSQL {
    param(
        [String]$PostgresPath
    )
    $pgdata=Join-Path $PostgresPath "data"
    Start-Process -FilePath pg_ctl -ArgumentList ("-D", "$pgdata", "stop")
    Write-Host "PostgreSQL has been successfully started."
}
function Validate-PostgreSQL {
    $pgready = Start-Process -FilePath pg_isready -Wait -PassThru
    $exitCode = $pgready.ExitCode
    if ($exitCode -eq 0)
    {
        Write-Host -Object "PostgreSQL has been successfully installed."
    }
    else
    {
        Write-Host -Object "PostgreSQL is not ready. Exitcode: $exitCode"
        exit $exitCode
    }
}

$paths=(Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
$pgservice=(Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").Name
$pgbin=$paths.split('"')[1].replace("\pg_ctl.exe", "")
$env:Path +=";$pgbin"
$pgroot=$paths.split('"')[1].replace("\bin\pg_ctl.exe", "")
$psqlVersion=pg_config --version | Out-String
Validate-PostgreSQL

# Adding description of the software to Markdown
$SoftwareName = "PostgreSQL"
$Description = @"
_Version:_ $psqlVersion<br/>
_Default Path:_ $pgroot
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

#Stop and disable PostgreSQL service
Stop-PostgreSQL -PostgresPath $pgroot
Set-Service $pgservice -StartupType Disabled
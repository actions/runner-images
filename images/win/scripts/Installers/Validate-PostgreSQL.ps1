$PGUSER="postgres"
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

$paths = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
$pgservice = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").Name
$pgroot = $paths.split('"')[1].replace("\bin\pg_ctl.exe", "")
$psqlVersion = pg_config --version | Out-String
Validate-PostgreSQL

# Adding description of the software to Markdown
$SoftwareName = "PostgreSQL"
$Description = @"
_Version:_ $psqlVersion<br/>
_Default Path:_ $pgroot<br/>
_User:_ $env:PGUSER<br/>
_Password:_ $env:PGPASSWORD
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

#Stop and disable PostgreSQL service
Stop-Service -Name $pgservice
Set-Service $pgservice -StartupType Disabled

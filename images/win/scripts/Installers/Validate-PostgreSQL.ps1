function Stop-PostgreSQL {
    param(
        [String]$PostgresPath
    )
    $pgbin=Join-path $PostgresPath "bin"
    $pgdata=Join-path $PostgresPath "data"
    $startPostgres=Join-path $pgbin "pg_ctl.exe"
    Start-Process -FilePath $startPostgres -ArgumentList ("-D", "$pgdata", "stop")
    Write-Host "PostgreSQL has been successfully started."
}

function Validate-PostgreSQL {
    param(
        [String]$PostgresPath
    )
    $pgbin=Join-path $PostgresPath "bin"
    $pgisreadypath=Join-path $pgbin "pg_isready.exe"
    $pgready = Start-Process -FilePath $pgisreadypath -Wait -PassThru
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

function Get-PostgreSQLVersion {
    param(
        [String]$PostgresPath
    )
    $pgbin=Join-path $PostgresPath "bin"
    $pgconfig=Join-path $pgbin "pg_config.exe"
    $psqlversion=Start-Process -FilePath $pgconfig -ArgumentList ("--version")-Wait -PassThru
    return $psqlversion
}

$paths=(Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
$pgroot=$paths.split('"')[1].replace("\bin\pg_ctl.exe", "")
$psqlVersion=Get-PostgreSQLVersion -PostgresPath $pgroot
Validate-PostgreSQL -PostgresPath $pgroot

# Adding description of the software to Markdown
$SoftwareName = "PostgreSQL"
$Description = @"
_Version:_ $psqlVersion<br/>
_Default Path:_ $pgroot
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

#Stop PostgreSQL service
Stop-PostgreSQL -PostgresPath $pgroot
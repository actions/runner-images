function Install-PostgreSQL {
    $installPath= choco install postgresql | Select-String "Installed to"
    return $installPath.Line.split("'")[1]
}

function Start-PostgreSQL {
    param(
        [String]$PostgresPath
    )
    $pgbin=Join-path $PostgresPath "bin"
    $pgdata=Join-path $PostgresPath "data"
    $startPostgres=Join-path $pgbin "pg_ctl.exe"
    $process = Start-Process -FilePath $startPostgres -ArgumentList ("-D", "$pgdata", "start")
    $exitCode = $process.ExitCode
    if ($exitCode -eq 0)
    {
      Write-Host -Object "PostgreSQL has been successfully started."
    }
    else
    {
      Write-Host -Object "PostgreSQL cannot be started. Exitcode: $exitCode"
      exit $exitCode
    }
}

function Ready-PostgreSQL {
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

function Version-PostgreSQL {
    param(
        [String]$PostgresPath
    )
    $pgbin=Join-path $PostgresPath "bin"
    $pgconfig=Join-path $pgbin "pg_config.exe"
    $psqlversion=Start-Process -FilePath $pgconfig -ArgumentList ("--version")-Wait -PassThru
    return $psqlversion
}

$psqlDir=Install-PostgreSQL
$psqlVersion=Version-PostgreSQL -PostgresPath $psqlDir
Start-PostgreSQL -PostgresPath $psqlDir
Ready-PostgreSQL -PostgresPath $psqlDir


# Adding description of the software to Markdown
$SoftwareName = "PostgreSQL"
$Description = @"
_Version:_ $psqlVersion<br/>
_Default Path:_ $psqlDir
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
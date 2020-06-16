$pgReady = Start-Process -FilePath pg_isready -Wait -PassThru
$exitCode = $pgReady.ExitCode

if ($exitCode -eq 0)
{
    Write-Host -Object "PostgreSQL has been successfully installed."
}
else
{
    Write-Host -Object "PostgreSQL is not ready. Exitcode: $exitCode"
    exit $exitCode
}

#Stop and disable PostgreSQL service
$pgService = Get-Service -Name postgresql*
Stop-Service -InputObject $pgService
Set-Service -InputObject $pgService -StartupType Disabled

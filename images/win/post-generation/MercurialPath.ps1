$hgPath = "$Env:ProgramFiles\Mercurial\"
$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)

if (Test-Path -Path $hgPath)
{
    $latestPath = "$hgPath;$latestPath"
    Write-Host "Added Mercurial to PATH"
}

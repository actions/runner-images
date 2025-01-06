################################################################################
##  File: Install-NativeImages.ps1
##  Desc: Generate and install native images for .NET assemblies
################################################################################

Write-Host "NGen: install Microsoft.PowerShell.Utility.Activities..."
& $env:SystemRoot\Microsoft.NET\Framework64\v4.0.30319\ngen.exe install "Microsoft.PowerShell.Utility.Activities, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Installation of Microsoft.PowerShell.Utility.Activities failed with exit code $LASTEXITCODE"
}

Write-Host "NGen: update x64 native images..."
& $env:SystemRoot\Microsoft.NET\Framework64\v4.0.30319\ngen.exe update | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Update of x64 native images failed with exit code $LASTEXITCODE"
}

Write-Host "NGen: update x86 native images..."
& $env:SystemRoot\Microsoft.NET\Framework\v4.0.30319\ngen.exe update | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Update of x86 native images failed with exit code $LASTEXITCODE"
}

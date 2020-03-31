# Serialized Certificate Store File
$sstFile = "$env:TEMP\roots.sst"
# Generate SST from Windows Update
$result = certutil.exe -generateSSTFromWU $sstFile
if ($LASTEXITCODE -ne 0) {
    Write-Host "[Error]: failed to generate $sstFile sst file`n$result"
    exit $LASTEXITCODE
}

$result = certutil.exe -dump $sstFile
if ($LASTEXITCODE -ne 0) {
    Write-Host "[Error]: failed to dump $sstFile sst file`n$result"
    exit $LASTEXITCODE
}

try {
    Import-Certificate -FilePath $sstFile -CertStoreLocation Cert:\LocalMachine\Root
} catch {
    Write-Host "[Error]: failed to import ROOT CA`n$_"
    exit 1
}


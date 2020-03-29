# Serialized Certificate Store File
$sstFile = "$env:TEMP\roots.sst"
# Generate SST from Windows Update
$result = certutil.exe -generateSSTFromWU $sstFile
if ($LASTEXITCODE -eq 0) {
    # Dump certificates
    $result = certutil.exe -dump $sstFile
    if ($LASTEXITCODE -eq 0) {
        # Import Root CA into "Trusted Root Certification Authority"
        try {
            Import-Certificate -FilePath $sstFile -CertStoreLocation Cert:\LocalMachine\Root
        } catch {
            Write-Host "[Error]: failed to import ROOT CA`n$_"
        }
    }
    else {
        Write-Host "[Error]: failed to dump $sstFile sst file`n$result"
    }
}
else {
    Write-Host "[Error]: failed to generate $sstFile sst file`n$result"
}

exit $LASTEXITCODE
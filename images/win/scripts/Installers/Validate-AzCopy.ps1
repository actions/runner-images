if (Get-Command -Name 'azcopy') {
    Write-Host "azcopy $(azcopy --version) on path"
}
else {
    Write-Error "azcopy not on path"
    exit 1
}
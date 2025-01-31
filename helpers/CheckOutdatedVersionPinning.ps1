$ErrorActionPreference = 'Stop'

# Find all toolset JSON files
$toolsetFiles = Get-ChildItem -Recurse -Filter "toolset-*.json" | Where-Object { $_.Name -notlike "*schema.json" }

$expiringPins = @()
$now = Get-Date
$warningDays = 30 # Warn if expiring within 30 days

foreach ($file in $toolsetFiles) {
    Write-Host "Processing $($file.Name)"
    $content = Get-Content $file.FullName | ConvertFrom-Json

    # Recursively search for pinnedDetails in the JSON
    function Search-PinnedDetails {
        param($obj, $path)
        
        $foundPins = @()
        
        if ($obj -is [System.Management.Automation.PSCustomObject]) {
            foreach ($prop in $obj.PSObject.Properties) {
                if ($prop.Name -eq "pinnedDetails") {
                    Write-Host "Found pinned version at $path"
                    $reviewAt = [DateTime]::Parse($prop.Value.'review-at')
                    $daysUntilExpiry = ($reviewAt - $now).Days
                    
                    if ($daysUntilExpiry -lt $warningDays) {
                        Write-Host "Adding to expiringPins array"
                        $foundPins += @{
                            Path = $path
                            File = $file.Name
                            ReviewAt = $reviewAt
                            DaysUntilExpiry = $daysUntilExpiry
                            Reason = $prop.Value.reason
                            Link = $prop.Value.link
                        }
                    }
                } else {
                    $foundPins += Search-PinnedDetails -obj $prop.Value -path "$path.$($prop.Name)"
                }
            }
        } elseif ($obj -is [Array]) {
            for ($i = 0; $i -lt $obj.Count; $i++) {
                $foundPins += Search-PinnedDetails -obj $obj[$i] -path "$path[$i]"
            }
        }
        
        return $foundPins
    }

    $expiringPins += Search-PinnedDetails -obj $content -path $file.Name
}

if ($expiringPins) {
    $issueBody = "# Version Pinning Review Required`n`n"
    $issueBody += "The following pinned versions need review:`n`n"
    
    foreach ($pin in $expiringPins) {
        $status = if ($pin.DaysUntilExpiry -lt 0) { "EXPIRED" } else { "Expiring Soon" }
        $issueBody += "## $($status) - $($pin.Path)`n"
        $issueBody += "- **File**: $($pin.File)`n"
        $issueBody += "- **Review Date**: $($pin.ReviewAt.ToString('yyyy-MM-dd'))`n"
        $issueBody += "- **Days until expiry**: $($pin.DaysUntilExpiry)`n"
        $issueBody += "- **Reason**: $($pin.Reason)`n"
        $issueBody += "- **Original PR**: $($pin.Link)`n`n"
    }

    if ($env:GITHUB_ACTIONS -eq 'true') {
        # In GitHub Actions, create an issue
        Write-Host "Creating issue"
        $tempFile = [System.IO.Path]::GetTempFileName()
        Set-Content -Path $tempFile -Value $issueBody
        gh issue create --title "Version Pinning Review Found Expired Pinned Versions" --body-file $tempFile
        Remove-Item -Path $tempFile
    }
    
    Write-Host "`nIssue Content:`n"
    Write-Host $issueBody
}
else {
    Write-Host "No expiring pins found."
    if ($env:GITHUB_ACTIONS -eq 'true') {
        "expired_pins=0" >> $env:GITHUB_OUTPUT
    }
}

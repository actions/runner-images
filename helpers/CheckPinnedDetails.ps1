$ErrorActionPreference = 'Stop'

function Get-PinnedDetailsRecursive($obj) {
    $pinnedDetails = @()

    if ($obj -is [System.Management.Automation.PSCustomObject]) {
        if ($obj.PSObject.Properties.Name -contains "review-at") {
            $pinnedDetails += $obj
        }
        foreach ($prop in $obj.PSObject.Properties) {
            Get-PinnedDetailsRecursive $prop.Value
        }
    }
    elseif ($obj -is [Array]) {
        foreach ($item in $obj) {
            Get-PinnedDetailsRecursive $item
        }
    }

    return $pinnedDetails
}

Write-Host "Checking pinned details for overdue review dates"

# Find all toolset JSON files in the current directory and subdirectories
$toolsetFiles = Get-ChildItem -Recurse -Filter "toolset-*.json"

foreach ($toolsetFile in $toolsetFiles) {
    Write-Host "Checking $toolsetFile"

    # Skip schema file
    if ($toolsetFile.Name -like "*toolset-schema.json") {
        continue
    }

    # Get all objects with 'review-at' property from the JSON file
    $jsonContent = Get-Content $toolsetFile.FullName | ConvertFrom-Json

    $pinnedDetails = Get-PinnedDetailsRecursive $jsonContent | Where-Object { $_ -ne $null }

    foreach ($pinnedDetail in $pinnedDetails) {
        $reviewDate = $pinnedDetail.'review-at'
        $reason = $pinnedDetail.reason

        Write-Host "Info: Review date $reviewDate, reason $reason"

        if (![string]::IsNullOrEmpty($reviewDate)) {
            $reviewDateTime = [DateTime]::Parse($reviewDate)
            $currentTime = Get-Date
            $sevenDaysAgo = $currentTime.AddDays(-7)

            Write-Host "Info: Review date $reviewDate, current time $currentTime"

            # Check if review date is in the past
            if ($reviewDateTime -lt $currentTime) {
                Write-Host "ERROR: Overdue review date: $reviewDate for tool in $($toolsetFile.Name)"
                Write-Host "       Pinned for '$reason'"
                Write-Host ""
            }

            # Check if review date is within the next 7 days
            if ($reviewDateTime -gt $sevenDaysAgo -and $reviewDateTime -le $currentTime) {
                Write-Host "WARNING: Review date is coming up within the next 7 days: $reviewDate for tool in $($toolsetFile.Name)"
                Write-Host "         Pinned for '$reason'"
                Write-Host ""
            }
        }
    }
}

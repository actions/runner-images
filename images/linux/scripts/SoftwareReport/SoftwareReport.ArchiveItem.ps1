class ArchiveItem {
    [string] $Id
    [string] $Title
    [string[]] $Headers
}

class ArchiveItems {
    hidden [System.Collections.ArrayList] $items
    hidden [string[]] $activeHeaders

    ArchiveItems() {
        $this.items = New-Object System.Collections.ArrayList
        $this.activeHeaders = New-Object string[] 5
    }

    [string] Add($Title, $Id) {
        $item = [ArchiveItem]::New()
        $item.Id = $Id
        $item.Title = $Title
        $item.Headers = $this.activeHeaders | ForEach-Object { $_ } | Where-Object { $_.Length -ge 1 }
        $this.items.Add($item) | Out-Null

        return $Title
    }

    [string] Add($TitleIdPair) {
        return $this.Add($TitleIdPair[0], $TitleIdPair[1])
    }

    [string] SetHeader($Name, $Level) {
        if ($Level -lt 1 -or $Level -gt $this.activeHeaders.Length) {
            Write-Warning"[!] [ArchiveItems] Header level must be 1..5"
            return $Name
        }

        $this.activeHeaders[$Level-1] = $Name
        for ($i = $Level; $i -lt $this.activeHeaders.Length; $i++) {
            $this.activeHeaders[$i] = ""
        }
        return $Name
    }

    [string] ToJson() {
        $final = @()
        foreach ($item in $this.items) {
            $headersLevel = $item.Headers.Count
            $headers = $headersLevel -ge 4 ? @($item.Headers[$headersLevel-2], $item.Headers[$headersLevel-1]) : @($item.Headers[$headersLevel-1])

            $final += [PSCustomObject]@{
                Id = $item.Id
                Title = $item.Title
                Headers = $headers
            }
        }
        return ConvertTo-Json $final -Depth 10
    }

    [string] ToJsonGrouped() {
        [string[]] $lastHeaders = ($this.items[0]).Headers
        [string] $headersPath = ""
        $final = @()
        $groupItems = @()

        foreach ($item in $this.items) {
            $headersLevel = $lastHeaders.Count
            $headersPath = $headersLevel -ge 4 ? ($lastHeaders[$headersLevel-2] + " | " + $lastHeaders[$headersLevel-1]) : $lastHeaders[$headersLevel-1]

            $isSameGroup = -not (Compare-Object $item.Headers $lastHeaders)
            if (-not $isSameGroup) {
                $final += [PSCustomObject]@{
                    $headersPath = $groupItems
                }
                $lastHeaders = $item.Headers
                $groupItems = @()
            }

            $groupItems += [PSCustomObject]@{
                $item.Id = $item.Title
            }   
        }
        $final += [PSCustomObject]@{
            $headersPath = $groupItems
        }

        return ConvertTo-Json $final -Depth 10
    }
}

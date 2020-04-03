function Install-Choco {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$install,
        [int]$retries = 5
    )

    begin { }
    process {
        $condition = $false
        $count = 0
        do {
            Write-Output "running: powershell choco install $install -y"
            powershell choco install $install -y

            $installed = powershell choco list -lo $install --all
            $match = (($installed -match "^$install.*").Length -ne 0)
            if ($match) {
                Write-Output "package installed: $install"
                $condition = $true
            }
            else {
                $count++
                if ($count -eq $retries) {
                    Write-Error "Could not install $install after $count attempts"
                    exit 1
                }
            }
        } while ($condition -eq $false)
    }
    end { }
}
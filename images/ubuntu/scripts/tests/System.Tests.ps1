# The $env:AGENT_NAME and $env:RUNNER_NAME are predefined variables for the ADO pipelines and for the GitHub actions respectively.
# If the test is running on the ADO pipeline or on the GitHub actions, the test will be skipped
Describe "Disk free space" -Skip:(-not [String]::IsNullOrEmpty($env:AGENT_NAME) -or -not [String]::IsNullOrEmpty($env:RUNNER_NAME)) {
    It "Image has enough free space" {
        $diskInfo = Get-PSDrive "/"
        $totalSpaceGB = [math]::Floor(($diskInfo.Used + $diskInfo.Free) / 1GB)
        $freeSpaceGB = [math]::Floor($diskInfo.Free / 1GB)
        Write-Host "  [i] Disk size: ${totalSpaceGB} GB; Free space: ${freeSpaceGB} GB"
        $freeSpaceGB | Should -BeGreaterOrEqual 17
    }
}

Describe "fwupd removed" {
    It "Is not present on box" {
        $systemctlOutput = & systemctl list-units fwupd-refresh.timer --no-legend
        # When disabled the output looks like this:
        #❯ systemctl list-units fwupd-refresh.timer --no-legend
        #● fwupd-refresh.timer masked failed failed fwupd-refresh.timer
        # When enabled the output looks like this:
        #❯ systemctl list-units fwupd-refresh.timer --no-legend
        #fwupd-refresh.timer loaded active waiting Refresh fwupd metadata regularly
        $systemctlOutput | Should -Not -Match "active"
    }
}

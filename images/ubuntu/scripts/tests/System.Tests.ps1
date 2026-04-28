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

# https://github.com/actions/runner-images/issues/13770
# Linux kernel 6.17 changed read_ahead_kb from 128 to 4096 on Azure VMs, causing I/O thrashing
Describe "ReadAhead udev rule" -Skip:(-not (Test-IsUbuntu24)) {
    It "udev rule file exists" {
        "/etc/udev/rules.d/99-readahead.rules" | Should -Exist
    }

    It "udev rule contains correct read_ahead_kb value" {
        $content = Get-Content "/etc/udev/rules.d/99-readahead.rules" -Raw
        $content | Should -Match 'ATTR\{queue/read_ahead_kb\}="128"'
    }

    It "All sd* devices have read_ahead_kb set to 128" {
        $devices = Get-ChildItem "/sys/block/sd*/queue/read_ahead_kb" -ErrorAction SilentlyContinue
        $devices | Should -Not -BeNullOrEmpty -Because "there should be at least one sd* block device"
        foreach ($dev in $devices) {
            $value = (Get-Content $dev.FullName).Trim()
            $value | Should -Be "128" -Because "read_ahead_kb for $($dev.FullName) should be 128 to prevent I/O thrashing"
        }
    }
}

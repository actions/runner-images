# The $env:AGENT_NAME and $env:RUNNER_NAME are predefined variables for the ADO pipelines and for the GitHub actions respectively.
# If the test is running on the ADO pipeline or on the GitHub actions, the test will be skipped
Describe "Disk free space" -Skip:(-not [String]::IsNullOrEmpty($env:AGENT_NAME) -or -not [String]::IsNullOrEmpty($env:RUNNER_NAME)) {
    It "Image has enough free space" {
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 17GB
    }
}

Describe "fwupd removed" {
    It "Is not present on box" {
        $systemctlOutput = & systemctl list-unit-files fwupd-refresh.timer
        # When enabled the output looks like this:
        #❯ systemctl list-unit-files fwupd-refresh.timer
        #UNIT FILE           STATE   VENDOR PRESET
        #fwupd-refresh.timer enabled enabled
        #1 unit files listed.
        $systemctlOutput | Should -Not -Match "enabled"
    }
}

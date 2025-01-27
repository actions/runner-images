# The $env:AGENT_NAME and $env:RUNNER_NAME are predefined variables for the ADO pipelines and for the GitHub actions respectively.
# If the test is running on the ADO pipeline or on the GitHub actions, the test will be skipped
Describe "Disk free space" -Skip:(-not [String]::IsNullOrEmpty($env:AGENT_NAME) -or -not [String]::IsNullOrEmpty($env:RUNNER_NAME)) {
    It "Image has enough free space" {
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 17GB
    }
}

Describe "Check apparmor unprivileged userns restrictions" {
    It "kernel.apparmor_restrict_unprivileged_userns == 0" {
        $value = Get-Content /proc/sys/kernel/apparmor_restrict_unprivileged_userns
        $value | Should -BeEqual 0
    }
}

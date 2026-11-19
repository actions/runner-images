################################################################################
##  File:  Hostname.Tests.ps1
##  Desc:  Validate the actual VM hostname and resolver behavior without repairing it
################################################################################

Describe "Hostname resolution" {
    It "The system hostname does not depend on .local multicast resolution" {
        (hostname).Trim() | Should -Not -Match '\.local$'
    }

    It "<Lookup> resolves the VM hostname within two seconds" -TestCases @(
        @{ Lookup = "getaddrinfo" }
        @{ Lookup = "getfqdn" }
        @{ Lookup = "gethostbyaddr" }
    ) {
        param ([string] $Lookup)

        $output = python3 "$PSScriptRoot/hostname-resolution.py" --lookup $Lookup 2>&1 | Out-String
        $LASTEXITCODE | Should -Be 0 -Because $output
    }
}

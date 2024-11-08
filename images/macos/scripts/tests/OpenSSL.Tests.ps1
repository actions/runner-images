Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "OpenSSL" {
    Context "OpenSSL Version" {
        It "OpenSSL is available" {
            "openssl version" | Should -ReturnZeroExitCode
        }
    }

    Context "OpenSSL 1.1 is default" {
        It "Default OpenSSL version is 1.1" {
            $commandResult = Get-CommandResult "openssl version"
            $commandResult.Output | Should -Match "OpenSSL 1.1"
        }
    }
}

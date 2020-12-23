Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "OpenSSL" {
    It "OpenSSL is available" {
        "openssl version" | Should -ReturnZeroExitCode
    }

    It "OpenSSL 1.1 path exists" {
        $openSSLpath = "/usr/local/opt/openssl@1.1"
        $openSSLpath | Should -Exist
    }

    It "Default OpenSSL version is 1.1" {
        $commandResult = Get-CommandResult "openssl version"
        $commandResult.Output | Should -Match "OpenSSL 1.1"
    }
}
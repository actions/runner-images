Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "OpenSSL" {
    Context "OpenSSL Version" {
        It "OpenSSL is available" {
            "openssl version" | Should -ReturnZeroExitCode
        }
    }

    Context "OpenSSL 3 Path Check" {
        It "OpenSSL 3 path exists" {
            $openSSLpath = brew --prefix openssl@3
            $openSSLpath | Should -Exist
        }
    }

    Context "OpenSSL 3 is default" {
        It "Default OpenSSL version is 3" {
            $commandResult = Get-CommandResult "openssl version"
            $commandResult.Output | Should -Match "OpenSSL 3"
        }
    }
}

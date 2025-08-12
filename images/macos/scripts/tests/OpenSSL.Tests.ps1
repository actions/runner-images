Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "OpenSSL" {
    Context "OpenSSL Version" {
        It "OpenSSL is available" {
            "openssl version" | Should -ReturnZeroExitCode
        }
    }

    Context "OpenSSL 1.1 Path Check" -Skip:($os.IsTahoe) {
        It "OpenSSL 1.1 path exists" {
            $openSSLpath = brew --prefix openssl@1.1
            $openSSLpath | Should -Exist
        }
    }

    Context "OpenSSL 1.1 is default" -Skip:($os.IsTahoe) {
        It "Default OpenSSL version is 1.1" {
            $commandResult = Get-CommandResult "openssl version"
            $commandResult.Output | Should -Match "OpenSSL 1.1"
        }
    }

    Context "OpenSSL 3 Path Check" -Skip:(-not $os.IsTahoe) {
        It "OpenSSL 3 path exists" {
            $openSSLpath = brew --prefix openssl@3
            $openSSLpath | Should -Exist
        }
    }

    Context "OpenSSL 3 is default" -Skip:(-not $os.IsTahoe) {
        It "Default OpenSSL version is 3" {
            $commandResult = Get-CommandResult "openssl version"
            $commandResult.Output | Should -Match "OpenSSL 3"
        }
    }
}

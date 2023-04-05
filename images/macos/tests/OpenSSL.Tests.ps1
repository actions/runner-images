Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
$os = Get-OSVersion

Describe "OpenSSL" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    Context "OpenSSL Version" {
        It "OpenSSL is available" {
            "openssl version" | Should -ReturnZeroExitCode
        }
    }

    Context "OpenSSL 1.1 Path Check" {
        It "OpenSSL 1.1 path exists" {
            $openSSLpath = "/usr/local/opt/openssl@1.1"
            $openSSLpath | Should -Exist
        }
    }
    
    Context "OpenSSL 1.1 is default" {
        It "Default OpenSSL version is 1.1" {
            $commandResult = Get-CommandResult "openssl version"
            $commandResult.Output | Should -Match "OpenSSL 1.1"
        }
    }
}
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Apache" -Skip:(Test-IsContainer) {
    It "Apache CLI" {
        "apache2 -v" | Should -ReturnZeroExitCode
    }

    It "Apache Service" {
        "sudo systemctl start apache2" | Should -ReturnZeroExitCode
        "apachectl configtest" | Should -ReturnZeroExitCode
        "sudo systemctl stop apache2" | Should -ReturnZeroExitCode
    }
}

Describe "Nginx" -Skip:(Test-IsContainer) {
    It "Nginx CLI" {
        "nginx -v" | Should -ReturnZeroExitCode
    }

    It "Nginx Service" {
        "sudo systemctl start nginx" | Should -ReturnZeroExitCode
        "sudo nginx -t" | Should -ReturnZeroExitCode
        "sudo systemctl stop nginx" | Should -ReturnZeroExitCode
    }
}
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Apache" -Skip:($os.IsVenturaArm64) {
    It "Apache CLI" {
        "httpd -v" | Should -ReturnZeroExitCode
    }

    It "Apache Service" {
        brew services list | Out-String | Should -Match "httpd\s+(stopped|none)"
    }
}

Describe "Nginx" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Nginx CLI" {
        "nginx -v" | Should -ReturnZeroExitCode
    }

    It "Nginx Service" {
        brew services list | Out-String | Should -Match "nginx\s+(stopped|none)"
    }
}

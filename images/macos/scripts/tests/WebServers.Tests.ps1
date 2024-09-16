Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Apache" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Apache CLI" {
        "httpd -v" | Should -ReturnZeroExitCode
    }

    It "Apache Service" {
        $service = brew services list --json | ConvertFrom-Json | Where-Object { $_.name -eq "httpd" }
        $service.status | Should -Match "(stopped|none)"
    }
}

Describe "Nginx" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Nginx CLI" {
        "nginx -v" | Should -ReturnZeroExitCode
    }

    It "Nginx Service" {
        $service = brew services list --json | ConvertFrom-Json | Where-Object { $_.name -eq "nginx" }
        $service.status | Should -Match "(stopped|none)"
    }
}

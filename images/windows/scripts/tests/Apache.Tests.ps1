Describe "Apache" {
    Context "Path" {
        It "Apache" {
            $apachePath = Join-Path (Join-Path "C:\tools\" (Get-Item C:\tools\apache*).Name) "\bin\httpd"
            "$apachePath -V" | Should -ReturnZeroExitCode
        }
    }

    Context "Service" {
        $apacheService = Get-Service -Name Apache
        $apacheServiceTests = @{
            Name = $apacheService.Name
            Status = $apacheService.Status
            StartType = $apacheService.StartType
        }

        It "<Name> service is stopped" -TestCases $apacheServiceTests {
            $Status | Should -Be "Stopped"
        }

        It "<Name> service is disabled" -TestCases $apacheServiceTests {
            $StartType | Should -Be "Disabled"
        }
    }
}

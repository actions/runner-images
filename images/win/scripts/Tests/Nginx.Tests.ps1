Describe "Nginx" {
    Context "Path" {
        It "Nginx" {
            $nginxPath = Join-Path (Join-Path "C:\tools\" (Get-Item C:\tools\nginx*).Name) "\nginx"
            "$nginxPath -v" | Should -ReturnZeroExitCode
        }
    }

    Context "Service" {
        $nginxService = Get-Service -Name nginx
        $nginxServiceTests = @{
            Name = $nginxService.Name
            Status = $nginxService.Status
            StartType = $nginxService.StartType
        }

        It "<Name> service is stopped" -TestCases $nginxServiceTests {
            $Status | Should -Be "Stopped"
        }

        It "<Name> service is disabled" -TestCases $nginxServiceTests {
            $StartType | Should -Be "Disabled"
        }
    }
}

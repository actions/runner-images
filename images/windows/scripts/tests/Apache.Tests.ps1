Describe "Apache" {
    BeforeAll {
        $apachePath = Join-Path "C:\tools\" (Get-Item C:\tools\apache*).Name
    }

    Context "Path" {
        It "Apache" {
            "$apachePath\bin\httpd -V" | Should -ReturnZeroExitCode
        }
    }

    Context "Version" {
        It "Apache is at least 2.4.71" {
            (& "$apachePath\bin\httpd.exe" -v | Out-String) -match "Apache/(?<version>\d+\.\d+\.\d+)" | Should -BeTrue
            [version] $Matches.version | Should -BeGreaterOrEqual ([version] "2.4.71")
        }

        It "Bundled OpenSSL is 3.x" {
            Join-Path $apachePath "bin\libcrypto-1_1-x64.dll" | Should -Not -Exist
            (Get-Item (Join-Path $apachePath "bin\libcrypto-3*.dll")).VersionInfo.ProductVersion | Should -Match "^3\."
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

Describe "Chrome" {
    Context "WebDriver" {
        It "ChromeWebDriver environment variable and path exists" {
            $env:ChromeWebDriver | Should -Not -BeNullOrEmpty
            $env:ChromeWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\ChromeDriver"
            $env:ChromeWebDriver | Should -Exist
        }

        It "chromedriver.exe exists" {
            "$env:ChromeWebDriver\chromedriver.exe" | Should -Exist
        }

        It "versioninfo.txt exists" {
            "$env:ChromeWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Chrome" {
        $chromeRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"

        It "$edgeRegPath registry path exists" -TestCases @{chromeRegPath = $chromeRegPath} {
            $chromeRegPath | Should -Exist
        }

        It "Chrome VersionInfo registry value exists" -TestCases @{chromeRegPath = $chromeRegPath} {
            $versionInfo = (Get-Item (Get-ItemProperty $chromeRegPath).'(Default)').VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "gupdate is stopped" {
            $svc = Get-Service -Name gupdate
            $svc.Status | Should -BeExactly Stopped
        }

        It "gupdatem is stopped" {
            $svc = Get-Service -Name gupdatem
            $svc.Status | Should -BeExactly Stopped
        }

        It "BlockGoogleUpdate firewall rule exists" {
            Get-NetFirewallRule -DisplayName BlockGoogleUpdate | Should -Not -BeNullOrEmpty
        }

        It "chrome.exe is installed" {
            "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe" | Should -Exist
        }
    }
}

Describe "Edge" {
    Context "WebDriver" {
        It "EdgeWebDriver environment variable and path exists" {
            $env:EdgeWebDriver | Should -Not -BeNullOrEmpty
            $env:EdgeWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\EdgeDriver"
            $env:EdgeWebDriver | Should -Exist
        }

        It "msedgedriver.exe exists" {
            "$env:EdgeWebDriver\msedgedriver.exe" | Should -Exist
        }

        It "versioninfo.txt exists" {
            "$env:EdgeWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Firefox" {
        $edgeRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"

        It "$edgeRegPath registry path exists" -TestCases @{edgeRegPath = $edgeRegPath} {
            $edgeRegPath | Should -Exist
        }

        It "Edge VersionInfo registry value exists" -TestCases @{edgeRegPath = $edgeRegPath} {
            $versionInfo = (Get-Item (Get-ItemProperty $edgeRegPath).'(Default)').VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "msedge.exe is installed" {
            "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe" | Should -Exist
        }
    }
}

Describe "Firefox" {
    Context "GeckoWebDriver" {
        It "GeckoWebDriver environment variable and path exists" {
            $env:GeckoWebDriver | Should -Not -BeNullOrEmpty
            $env:GeckoWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\GeckoDriver"
            $env:GeckoWebDriver | Should -Exist
        }

        It "geckodriver.exe exists" {
            "$env:GeckoWebDriver\geckodriver.exe" | Should -Exist
        }

        It "versioninfo.txt exists" {
            "$env:GeckoWebDriver\versioninfo.txt" | Should -Exist
        }
    }

    Context "Firefox" {
        $firefoxRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"

        It "$firefoxRegPath registry path exists" -TestCases @{firefoxRegPath = $firefoxRegPath} {
            $firefoxRegPath | Should -Exist
        }

        It "Firefox VersionInfo registry value exists" -TestCases @{firefoxRegPath = $firefoxRegPath} {
            $versionInfo = (Get-Item (Get-ItemProperty $firefoxRegPath).'(Default)').VersionInfo
            $versionInfo | Should -Not -BeNullOrEmpty
        }

        It "firefox.exe is installed" {
            "$env:ProgramFiles\Mozilla Firefox\firefox.exe" | Should -Exist
        }
    }
}

Describe "Internet Explorer" {
    Context "IEWebDriver" {
        It "IEWebDriver environment variable and path exists" {
            $env:IEWebDriver | Should -Not -BeNullOrEmpty
            $env:IEWebDriver | Should -BeExactly "C:\SeleniumWebDrivers\IEDriver"
            $env:IEWebDriver | Should -Exist
        }

        It "geckodriver.exe exists" {
            "$env:IEWebDriver\IEDriverServer.exe" | Should -Exist
        }

        It "versioninfo.txt exists" {
            "$env:IEWebDriver\versioninfo.txt" | Should -Exist
        }
    }
}
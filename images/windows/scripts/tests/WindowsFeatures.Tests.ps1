Describe "WindowsFeatures" {
    $windowsFeatures = (Get-ToolsetContent).windowsFeatures
    $testCases = $windowsFeatures | ForEach-Object { @{ Name = $_.name; OptionalFeature = $_.optionalFeature } }

    It "Windows Feature <Name> is installed" -TestCases $testCases {
        if ($OptionalFeature) {
            (Get-WindowsOptionalFeature -Online -FeatureName $Name).State | Should -Be "Enabled"
        } else {
            (Get-WindowsFeature -Name $Name).InstallState | Should -Be "Installed"
        }
    }

    it "Check WSL is on path" {
        (Get-Command -Name 'wsl') | Should -BeTrue
    }

    it "Check WLAN service is stopped" {
        (Get-Service -Name wlansvc).Status | Should -Be "Stopped"
    }
}

Describe "DiskSpace" {
    It "The image has enough disk space"{
        $availableSpaceMB = [math]::Round((Get-PSDrive -Name C).Free / 1MB)
        $minimumFreeSpaceMB = 18 * 1024

        $availableSpaceMB | Should -BeGreaterThan $minimumFreeSpaceMB
    }
}

Describe "DynamicPorts" {
    It "Test TCP dynamicport start=49152 num=16384" {
        $tcpPorts = Get-NetTCPSetting | Where-Object { $_.SettingName -ne "Automatic" } | Where-Object {
            $_.DynamicPortRangeStartPort -ne 49152 -or $_.DynamicPortRangeNumberOfPorts -ne 16384
        }

        $tcpPorts | Should -BeNullOrEmpty
    }

    It "Test UDP dynamicport start=49152 num=16384" {
        $udpPorts = Get-NetUDPSetting | Where-Object {
            $_.DynamicPortRangeStartPort -ne 49152 -or $_.DynamicPortRangeNumberOfPorts -ne 16384
        }

        $udpPorts | Should -BeNullOrEmpty
    }
}

Describe "GDIProcessHandleQuota" {
    It "The GDIProcessHandleQuota value is 20000" {
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"
        $regPath32 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows"
        (Get-ItemProperty $regPath).GDIProcessHandleQuota | Should -BeExactly 20000
        (Get-ItemProperty $regPath32).GDIProcessHandleQuota | Should -BeExactly 20000
    }
}

Describe "Test Signed Drivers" {
    It "bcdedit testsigning should be Yes" {
        "$(bcdedit)" | Should -Match "testsigning\s+Yes"
    }
}

Describe "Windows Updates" {
    It "WindowsUpdateDone.txt should exist" {
        "$env:windir\WindowsUpdateDone.txt" | Should -Exist
    }

    $testCases = Get-WindowsUpdateStates | Sort-Object Title | ForEach-Object {
        @{
            Title = $_.Title
            State = $_.State
        }
    }

    It "<Title>" -TestCases $testCases {
        $expect = "Installed"
        if ( $Title -match "Microsoft Defender Antivirus" ) {
            $expect = "Installed", "Failed", "Running"
        }

        $State | Should -BeIn $expect
    }
}

Describe "WSL2" -Skip:((Test-IsWin19) -or (Test-IsWin22)) {
    It "WSL status should return zero exit code" {
        "wsl --status" | Should -ReturnZeroExitCode
    }
}

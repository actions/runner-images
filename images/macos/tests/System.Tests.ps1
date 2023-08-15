Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Disk free space" {
    It "Image has more than 10GB free space" {
        # we should have at least 10 GB of free space on macOS images
        # https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#capabilities-and-limitations
        $freeSpace = (Get-PSDrive "/").Free
        $freeSpace | Should -BeGreaterOrEqual 10GB
    }
}

Describe "Certificate" {
    It "Apple Worldwide Developer Relations Certification Authority[expired: 2030-02] is installed" {
        $sha1Hash = "06EC06599F4ED0027CC58956B4D3AC1255114F35"
        $certs = security find-certificate -a -c Worldwide -p -Z | Out-String
        $certs | Should -Match $sha1Hash
    }

    It "Developer ID Certification Authority[expired: 2031-09] is installed" {
        $sha1Hash = "5B45F61068B29FCC8FFFF1A7E99B78DA9E9C4635"
        $certs = security find-certificate -a -c "Developer ID" -p -Z | Out-String
        $certs | Should -Match $sha1Hash
    }
}

Describe "Audio device" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Sox is installed" {
        "sox --version" | Should -ReturnZeroExitCode
    }

    It "SwitchAudioSource is installed" {
        "SwitchAudioSource -c" | Should -ReturnZeroExitCode
    }

    It "Audio channel BlackHole 2ch" {
        SwitchAudioSource -c | Should -BeLikeExactly "BlackHole 2ch"
    }
}

Describe "Screen Resolution" -Skip:(isVeertu) {
    It "Screen Resolution" {
        system_profiler SPDisplaysDataType | Select-String "Resolution" | Should -Match "1176 x 885|1920 x 1080"
    }
}

Describe "Open windows" -Skip:(isVeertu) {
    It "Opened windows not found" {
        'tell application id "com.apple.systemevents" to get every window of (every process whose class of windows contains window)' | Tee-Object /tmp/windows.osascript
        $cmd = "osascript /tmp/windows.osascript"
        $openWindows = bash -c $cmd
        $openWindows.Split(",").Trim() | Where-Object { $_ -notmatch "NotificationCenter" } | Should -BeNullOrEmpty
    }
}

Describe "AutomationModeTool" {
    It "Does not require user authentication" -Skip:($os.IsBigSur) {
        automationmodetool | Out-String | Should -Match "DOES NOT REQUIRE"
    }
}

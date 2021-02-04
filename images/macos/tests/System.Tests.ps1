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
}

Describe "Audio device" -Skip:($os.IsHighSierra -or $os.IsBigSur) {
    It "Sox is installed" {
        "sox --version" | Should -ReturnZeroExitCode
    }

    It "SwitchAudioSource is installed" {
        "SwitchAudioSource -c" | Should -ReturnZeroExitCode
    }

    It "Audio channel Soundflower (2ch)" {
        SwitchAudioSource -c | Should -BeLikeExactly "Soundflower (2ch)"
    }
}

Describe "Screen Resolution" -Skip:($os.IsHighSierra) {
    It "Screen Resolution" {
        system_profiler SPDisplaysDataType | Select-String "Resolution" | Should -Match "1176 x 885"
    }
}

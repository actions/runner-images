Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Disk free space" {
    It "Image has more than 30GB free space" {
        # we should have at least 30 GB of free space on macOS images
        # 10GB here: https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#capabilities-and-limitations
        # 14GB here: https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/about-github-hosted-runners#standard-github-hosted-runners-for-public-repositories
        # 30GB due to: https://github.com/actions/runner-images/issues/10511
        $diskInfo = Get-PSDrive "/"
        $totalSpaceGB = [math]::Floor(($diskInfo.Used + $diskInfo.Free) / 1GB)
        $freeSpaceGB = [math]::Floor($diskInfo.Free / 1GB)
        Write-Host "  [i] Disk size: ${totalSpaceGB} GB; Free space: ${freeSpaceGB} GB"
        $freeSpaceGB | Should -BeGreaterOrEqual 30
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

Describe "AutomationModeTool" {
    It "Does not require user authentication" {
        automationmodetool | Out-String | Should -Match "DOES NOT REQUIRE"
    }
}

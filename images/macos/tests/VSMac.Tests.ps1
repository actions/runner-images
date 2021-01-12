Describe "VSMac" {
    It "VS4Mac is installed" {
        $vsPath = "/Applications/Visual Studio.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }
}
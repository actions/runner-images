Describe "Haskell" {
    $ghcPackagesPath = "c:\ghcup\ghc"
    [array] $ghcVersionList = Get-ChildItem -Path $ghcPackagesPath -Filter "*" | ForEach-Object { $_.Name.Trim() }
    $ghcCount = $ghcVersionList.Count
    $defaultGhcVersion = $ghcVersionList | Sort-Object {[Version] $_} | Select-Object -Last 1
    $ghcDefaultCases = @{
        defaultGhcVersion = $defaultGhcVersion
        defaultGhcShortVersion = ([version] $defaultGhcVersion).ToString(3)
    }

    $ghcTestCases = $ghcVersionList | ForEach-Object {
        $ghcVersion = $_
        $ghcShortVersion = ([version] $ghcVersion).ToString(3)
        $binGhcPath = Join-Path $ghcPackagesPath "$ghcShortVersion\bin\ghc.exe"
        @{
            ghcVersion = $ghcVersion
            ghcShortVersion = $ghcShortVersion
            binGhcPath = $binGhcPath
        }
    }

    $ghcupEnvExists = @(
        @{envVar = "GHCUP_INSTALL_BASE_PREFIX"}
        @{envVar = "GHCUP_MSYS2"}
    )

    If (Test-IsWin25) {
        $numberOfVersions = 1
    } else {
        $numberOfVersions = 3
    }

    It "<envVar> environment variable exists" -TestCases $ghcupEnvExists {
        Test-Path env:\$envVar
    }

    It "Accurate $numberOfVersions versions of GHC are installed" -TestCases @{ghcCount = $ghcCount; numberOfVersions = $numberOfVersions} {
        $ghcCount | Should -BeExactly $numberOfVersions
    }

    It "GHC <ghcVersion> is installed" -TestCases $ghcTestCases {
        "$binGhcPath --version" | Should -OutputTextMatchingRegex $ghcShortVersion
    }

    It "GHC <defaultGhcVersion> is the default version and should be the latest installed" -TestCases $ghcDefaultCases {
        "ghc --version" | Should -OutputTextMatchingRegex $defaultGhcShortVersion
    }

    It "Cabal is installed" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "cabal folder does not exist" {
        $env:CABAL_DIR | Should -Not -Exist
    }

    It "CABAL_DIR environment variable exists" {
        Get-EnvironmentVariable CABAL_DIR | Should -BeExactly "C:\cabal"
    }

    It "ghcup is installed" {
        "ghcup --version" | Should -ReturnZeroExitCode
    }

    It "ghcup can access msys2" {
        "ghcup run --mingw-path -- pacman --version" | Should -ReturnZeroExitCode
    }
}

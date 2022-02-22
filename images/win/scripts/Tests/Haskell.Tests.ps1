Describe "Haskell" {
    $chocoPackagesPath = Join-Path $env:ChocolateyInstall "lib"
    [array]$ghcVersionList = Get-ChildItem -Path $chocoPackagesPath -Filter "ghc.*" | ForEach-Object { $_.Name.TrimStart("ghc.") }
    $ghcCount = $ghcVersionList.Count
    $defaultGhcVersion = $ghcVersionList | Sort-Object {[Version]$_} | Select-Object -Last 1
    $ghcDefaultCases = @{
        defaultGhcVersion = $defaultGhcVersion
        defaultGhcShortVersion = ([version]$defaultGhcVersion).ToString(3)
    }

    $ghcTestCases = $ghcVersionList | ForEach-Object {
        $ghcVersion = $_
        $ghcShortVersion = ([version]$ghcVersion).ToString(3)
        $binGhcPath = Join-Path $chocoPackagesPath "ghc.$ghcVersion\tools\ghc-$ghcShortVersion\bin\ghc.exe"
        # The most recent GHC versions installation directory is $env:ChocolateyToolsLocation instead of $env:ChocolateyInstall\lib
        if (-not (Test-Path $binGhcPath))
        {
            $binGhcPath = Join-Path $env:ChocolateyToolsLocation "ghc-$ghcShortVersion\bin\ghc.exe"
        }
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

    It "<envVar> environment variable exists" -TestCases $ghcupEnvExists {
        Test-Path env:\$envVar
    }

    It "Accurate 3 versions of GHC are installed" -TestCases @{ghcCount = $ghcCount} {
        $ghcCount | Should -BeExactly 3
    }

    It "GHC <ghcVersion> is installed" -TestCases $ghcTestCases {
        "$binGhcPath --version" | Should -MatchCommandOutput $ghcShortVersion
    }

    It "GHC <defaultGhcVersion> is the default version and should be the latest installed" -TestCases $ghcDefaultCases {
        "ghc --version" | Should -MatchCommandOutput $defaultGhcShortVersion
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
}

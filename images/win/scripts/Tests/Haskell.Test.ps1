Describe "Haskell" {
    It "ghc" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    $chocoPackagesPath = Join-Path $env:ChocolateyInstall "lib"
    [array]$ghcVersionList = Get-ChildItem -Path $chocoPackagesPath -Filter "ghc.*" | ForEach-Object { $_.Name.TrimStart("ghc.") }
    $ghcCount = $ghcVersionList.Count

    It "Accurate 3 versions of GHC are installed" -TestCases @{ghcCount = $ghcCount} {
        $ghcCount | Should -BeExactly 3
    }

    $ghcTestCases = $ghcVersionList | ForEach-Object {
        @{
            ghcVersion = $_
        }
    }

    It "Validation each of GHC version" -TestCases $ghcTestCases {
        $binGhcPath = Join-Path $env:ChocolateyInstall "lib\ghc.$ghcVersion\tools\ghc-$ghcVersion\bin\ghc.exe"
        & $binGhcPath --version | Should -Match $ghcVersion
    }

    It "Default version of GHC should be the latest installed" {
        $defaultGhcVersion = $ghcVersionList | Sort-Object {[Version]$_} |Select-Object -Last 1
        ghc --version | Should -Match $defaultGhcVersion
    }
}
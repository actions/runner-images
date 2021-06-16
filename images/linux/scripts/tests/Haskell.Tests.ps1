Describe "Haskell" {

    $GHCCommonPath = "/opt/ghc"
    $GHCVersions = Get-ChildItem -Path $GHCCommonPath | Where-Object { $_.Name -match "\d+\.\d+" }
    
    $testCase = @{ GHCVersions = $GHCVersions }

    It "GHC directory contains two version of GHC" -TestCases $testCase {
        param ([object] $GHCVersions)
        $GHCVersions.Count | Should -Be 2
    }

    $testCases = $GHCVersions | ForEach-Object { @{ GHCPath = "${_}/bin/ghc"} }

    It "GHC version <GHCPath>" -TestCases $testCases {
            param ([string] $GHCPath)
            "$GHCPath --version" | Should -ReturnZeroExitCode
    }

    It "GHCup" {
        "ghcup --version" | Should -ReturnZeroExitCode
    }

    It "Default GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}
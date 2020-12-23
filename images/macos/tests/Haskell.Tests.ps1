Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "Haskell" -Skip:($os.IsHighSierra) {
    It "GHCup" {
        "ghcup --version" | Should -ReturnZeroExitCode
    }

    It "GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }
}
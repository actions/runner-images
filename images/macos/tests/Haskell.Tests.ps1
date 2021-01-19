$os = Get-OSVersion

Describe "Haskell" -Skip:($os.IsHighSierra) {
    Context "GHCup" {
        It "GHCup" {
            "ghcup --version" | Should -ReturnZeroExitCode
        }
    }
    Context "GHC" {
        It "GHC" {
            "ghc --version" | Should -ReturnZeroExitCode
        }
    }
    Context "Cabal" {
        It "Cabal" {
            "cabal --version" | Should -ReturnZeroExitCode
        }
    }
}
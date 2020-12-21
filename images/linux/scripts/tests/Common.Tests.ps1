Describe "Haskell" {
    It "GHC" {
        "ghc --version" | Should -ReturnZeroExitCode
    }

    It "Cabal" {
        "cabal --version" | Should -ReturnZeroExitCode
    }

    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}
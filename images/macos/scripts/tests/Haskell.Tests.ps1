Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
$os = Get-OSVersion

Describe "Haskell" -Skip:($os.IsVenturaArm64) {
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
    Context "Stack" {
        It "Stack" {
            "stack --version" | Should -ReturnZeroExitCode
        }

        It "Stack hook is not installed" {
            "$HOME/.stack/hooks/ghc-install.sh" | Should -Not -Exist
        }
    }
}
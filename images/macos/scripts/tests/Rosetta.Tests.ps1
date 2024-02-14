Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Rosetta" -Skip:(-not $os.IsArm64) {
    It "Rosetta is available" {
        $commandResult = Get-CommandResult "/usr/bin/pgrep oahd"
        $commandResult.Output | Should -Match "\d+"
        $commandResult.ExitCode | Should -Be 0
    }
}

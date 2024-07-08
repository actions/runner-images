Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "OC CLI" {
    It "OC CLI" {
        "oc version" | Should -ReturnZeroExitCode
    }
}

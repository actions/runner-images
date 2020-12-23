Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }
    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }

    It "AWS Session Manager CLI" {
        "session-manager-plugin --version" | Should -ReturnZeroExitCode
    }
}

Describe "Azcopy" {
    It "Azcopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}
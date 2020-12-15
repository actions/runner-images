Import-Module "/imagegeneration/helpers/Tests.Helpers.psm1" -DisableNameChecking

Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "azcopy" {
        $azcopyVersion = (Get-CommandResult "azcopy --version").Output
        $azcopyVersion | Should -Contain "azcopy"
    }

    It "azcopy10" {
        "azcopy10 --version" | Should -ReturnZeroExitCode
    }
}
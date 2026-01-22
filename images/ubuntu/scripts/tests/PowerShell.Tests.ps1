Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "PowerShell Core Multi-Version" {
    It "pwsh (default) is installed" {
        "pwsh --version" | Should -ReturnZeroExitCode
    }

    It "pwsh-stable is installed" {
        "pwsh-stable --version" | Should -ReturnZeroExitCode
    }

    It "pwsh-lts is installed" {
        "pwsh-lts --version" | Should -ReturnZeroExitCode
    }

    It "pwsh-preview is installed" {
        "pwsh-preview --version" | Should -ReturnZeroExitCode
    }

    It "pwsh-select helper is available" {
        "pwsh-select --help" | Should -ReturnZeroExitCode
    }

    It "pwsh versions directory exists" {
        "/opt/microsoft/powershell" | Should -Exist
    }

    Context "Version Channels" {
        $toolset = Get-ToolsetContent

        It "stable version matches toolset" {
            $expectedVersion = $toolset.pwsh.versions.stable
            $actualVersion = & pwsh-stable --version | Select-Object -First 1
            $actualVersion | Should -Match $expectedVersion
        }

        It "lts version matches toolset" {
            $expectedVersion = $toolset.pwsh.versions.lts
            $actualVersion = & pwsh-lts --version | Select-Object -First 1
            $actualVersion | Should -Match $expectedVersion
        }

        It "preview version matches toolset" {
            $expectedVersion = $toolset.pwsh.versions.preview
            $actualVersion = & pwsh-preview --version | Select-Object -First 1
            $actualVersion | Should -Match $expectedVersion
        }
    }
}

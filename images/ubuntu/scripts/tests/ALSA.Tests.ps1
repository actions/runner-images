Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "ALSA" {
    It "libasound2 is installed" {
        $result = Get-CommandResult "dpkg -s libasound2"
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match "Status: install ok installed"
    }

    It "libasound2-dev is installed" {
        $result = Get-CommandResult "dpkg -s libasound2-dev"
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match "Status: install ok installed"
    }

    It "alsa-utils is installed" {
        $result = Get-CommandResult "dpkg -s alsa-utils"
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match "Status: install ok installed"
    }

    It "ALSA development headers exist" {
        "/usr/include/alsa/asoundlib.h" | Should -Exist
    }

    It "ALSA pkgconfig file exists" {
        "/usr/lib/x86_64-linux-gnu/pkgconfig/alsa.pc" | Should -Exist
    }

    It "aplay command is available" {
        $result = Get-Command "aplay" -ErrorAction SilentlyContinue
        $result | Should -Not -BeNullOrEmpty
    }

    It "amixer command is available" {
        $result = Get-Command "amixer" -ErrorAction SilentlyContinue
        $result | Should -Not -BeNullOrEmpty
    }
}

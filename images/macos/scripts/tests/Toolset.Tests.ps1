Import-Module "$PSScriptRoot/Helpers.psm1"

$toolsets = Get-ChildItem -Path $PSScriptRoot -Filter "toolset-*.json"

function Get-ShortVersion([System.Version] $Version) {
    return [System.Version]::Parse($Version).ToString(2)
}

Describe "Toolset JSON validation" {
    $toolsets | ForEach-Object {
        It "$($_.Name) is valid" {
            $jsonContent = Get-Content -Raw $_.Fullname
            $jsonContent | Test-Json | Should -BeTrue
        }
    }
}

$toolsets | ForEach-Object {
    Describe "$($_.Name)" {
        $toolset = Get-Content -Raw $_.Fullname | ConvertFrom-Json

        Context "Xcode" {
            It "Default Xcode should be defined" {
                $toolset.xcode.default | Should -BeTrue
            }

            It "Default Xcode is listed in Xcode list" {
                $toolset.xcode.versions | Should -Contain $toolset.xcode.default
            }
        }
    }
}

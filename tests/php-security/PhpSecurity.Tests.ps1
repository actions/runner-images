BeforeAll {
    Import-Module "$PSScriptRoot/../../images/windows/scripts/helpers/ImageHelpers.psd1" -Force
}

Describe 'PHP installer package resolution' {
    It 'stops before installation when the selected branch is unavailable' {
        Mock Get-ToolsetContent { @{ php = @{ version = '8.4' } } }
        Mock Resolve-ChocoPackageVersion { $null }
        Mock Install-ChocoPackage { }

        { & "$PSScriptRoot/../../images/windows/scripts/build/Install-PHP.ps1" } |
            Should -Throw '*No approved PHP 8.4 package was found*'
        Should -Invoke Install-ChocoPackage -Exactly -Times 0
    }
}

Describe 'PHP security release validation' {
    It 'preserves an explicitly selected release branch' {
        { Assert-PhpSecurityVersion -Version '8.4.27' -ExpectedBranch '8.4' } | Should -Not -Throw
        { Assert-PhpSecurityVersion -Version '8.5.12' -ExpectedBranch '8.4' } | Should -Throw
        { Assert-PhpSecurityVersion -Version '9.0.0' -ExpectedBranch '8.5' } | Should -Throw
    }

    It 'accepts fixed and future stable release <Version>' -ForEach @(
        @{ Version = '8.2.35' }, @{ Version = '8.2.36' },
        @{ Version = '8.3.36' }, @{ Version = '8.3.37' },
        @{ Version = '8.4.27' }, @{ Version = '8.4.28' },
        @{ Version = '8.5.12' }, @{ Version = '8.5.13' },
        @{ Version = '8.6.0' }, @{ Version = '9.0.0' }
    ) {
        { Assert-PhpSecurityVersion -Version $Version } | Should -Not -Throw
    }

    It 'rejects unpatched or nonstable release <Version>' -ForEach @(
        @{ Version = '8.2.34' }, @{ Version = '8.3.35' },
        @{ Version = '8.4.26' }, @{ Version = '8.5.11' },
        @{ Version = '8.1.34' }, @{ Version = '7.4.33' },
        @{ Version = '8.5.12RC1' }, @{ Version = '8.6.0-dev' },
        @{ Version = 'not-a-version' }, @{ Version = '8.5.12.1' }
    ) {
        { Assert-PhpSecurityVersion -Version $Version } | Should -Throw
    }
}

BeforeAll {
    Import-Module "$PSScriptRoot/../../images/windows/scripts/helpers/ImageHelpers.psd1" -Force
}

Describe 'PHP security release validation' {
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

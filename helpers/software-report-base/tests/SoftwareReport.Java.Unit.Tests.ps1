BeforeAll {
    Import-Module "$PSScriptRoot/../JavaVersion.psm1" -Force
}

Describe "Java full version parsing" {
    It "Preserves the patch and build in <Output>" -TestCases @(
        @{ Output = 'openjdk full version "21.0.13.1+2-LTS"'; Expected = "21.0.13.1+2" }
        @{ Output = 'openjdk full version "17.0.21.1+2"'; Expected = "17.0.21.1+2" }
        @{ Output = 'openjdk full version "21.0.13+9-LTS"'; Expected = "21.0.13+9" }
        @{ Output = 'openjdk full version "1.8.0_512-b09"'; Expected = "8.0.512+9" }
    ) {
        ConvertFrom-JavaFullVersion $Output | Should -BeExactly $Expected
    }

    It "Rejects unrecognized output <Output>" -TestCases @(
        @{ Output = "unknown version" }
        @{ Output = 'openjdk full version "not-a-version"' }
    ) {
        { ConvertFrom-JavaFullVersion $Output } | Should -Throw
    }

    It "Fails when Java is missing" {
        { Get-InstalledJavaVersion -JavaHome $TestDrive } | Should -Throw "*Java executable not found*"
    }
}

# Upgrade Pester to 4.10.1
Install-Module Pester -RequiredVersion 4.10.1 -Scope AllUsers -SkipPublisherCheck -Force

Add-AssertionOperator -Name ReturnZeroExitCode -Test  $function:ShouldReturnZeroExitCode
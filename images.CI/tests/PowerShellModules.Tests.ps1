################################################################################
##  File:  PowerShellModules.Tests.ps1
##  Desc:  Tests for installed Azure modules validation
################################################################################

BeforeAll {
    $testFile = Join-Path $PSScriptRoot "../../images/ubuntu/scripts/tests/PowerShellModules.Tests.ps1"
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($testFile, [ref]$null, [ref]$null)
    $azureModules = $ast.Find({
        param($node)
        $node -is [System.Management.Automation.Language.CommandAst] -and
            $node.GetCommandName() -eq "Describe" -and
            $node.CommandElements[1].Value -eq "AzureModules"
    }, $true)
    # Execute the image test itself without running unrelated image validation.
    $azureModuleTest = $azureModules.Find({
        param($node)
        $node -is [System.Management.Automation.Language.CommandAst] -and $node.GetCommandName() -eq "It"
    }, $true).CommandElements[-1].ScriptBlock.GetScriptBlock().ToString()
    $pesterManifest = Join-Path (Get-Module Pester).ModuleBase "Pester.psd1"
}

Describe "AzureModules directory-specific version validation" {
    It "<name>" -ForEach @(
        @{ name = "accepts the exact target version"; targetVersions = @("15.6.1"); externalVersions = @(); shouldPass = $true }
        @{ name = "accepts the expected version among multiple target and external versions"; targetVersions = @("15.6.1", "15.5.0"); externalVersions = @("15.4.0"); shouldPass = $true }
        @{ name = "rejects the expected version installed only externally"; targetVersions = @(); externalVersions = @("15.6.1"); shouldPass = $false }
        @{ name = "rejects a different target version"; targetVersions = @("15.5.0"); externalVersions = @(); shouldPass = $false }
        @{ name = "rejects a partial version match"; targetVersions = @("15.6.10"); externalVersions = @(); shouldPass = $false }
        @{ name = "rejects an absent module"; targetVersions = @(); externalVersions = @(); shouldPass = $false }
    ) {
        $caseRoot = Join-Path $TestDrive ([guid]::NewGuid().ToString())
        $modulePath = Join-Path $caseRoot "target"
        $externalPath = Join-Path $caseRoot "external"
        $moduleName = "AzureModulesRegression"
        foreach ($installation in @(
            @{ path = $modulePath; versions = $targetVersions }
            @{ path = $externalPath; versions = $externalVersions }
        )) {
            New-Item -Path $installation.path -ItemType Directory -Force | Out-Null
            foreach ($version in $installation.versions) {
                $versionPath = Join-Path $installation.path "$moduleName/$version"
                New-Item -Path $versionPath -ItemType Directory -Force | Out-Null
                New-ModuleManifest -Path "$versionPath/$moduleName.psd1" -ModuleVersion $version
            }
        }

        # Only the outer job inherits the external installation; the image test starts its own child job.
        $job = Start-Job -ScriptBlock {
            param($testBody, $pesterManifest, $modulePath, $externalPath, $moduleName)
            $ErrorActionPreference = "Stop"
            Import-Module $pesterManifest
            $env:PSModulePath = $externalPath
            $expectedVersion = "15.6.1"
            & ([scriptblock]::Create($testBody))
        } -ArgumentList $azureModuleTest, $pesterManifest, $modulePath, $externalPath, $moduleName

        try {
            if ($shouldPass) {
                { $job | Receive-Job -Wait -ErrorAction Stop } | Should -Not -Throw
            } else {
                { $job | Receive-Job -Wait -ErrorAction Stop } | Should -Throw -ExpectedMessage "*Expected*"
            }
        } finally {
            Remove-Job $job -Force
        }
    }
}

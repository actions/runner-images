Describe "Vsix" {
    $toolset = Get-ToolsetContent
    $requiredVsixs = $toolset.visualStudio.vsix

    $allPackages = (Get-VSSetupInstance | Select-VsSetupInstance -Product *).Packages
    $testCases = $requiredVsixs | ForEach-Object {
        $vsix = Get-VsixExtenstionFromMarketplace -MarketplaceUri $_.url -ExtensionName $_.name
        @{
            VsixName = $vsix.ExtensionName
            VsixId = $vsix.VsixId
            AllPackages = $allPackages
        }
    }
    if ($testCases.Count -gt 0) {
        It "Extension <VsixName>" -TestCases $testCases {
            $objVsix = $AllPackages | Where-Object { $_.id -eq $VsixId }
            $objVsix | Should -Not -BeNullOrEmpty
        }
    }
}
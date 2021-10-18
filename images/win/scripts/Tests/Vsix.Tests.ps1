Describe "Vsix" {
    $toolset = Get-ToolsetContent
    $requiredVsixs = $toolset.visualStudio.vsix

    $allPackages = (Get-VisualStudioInstance).Packages
    $testCases = $requiredVsixs | ForEach-Object {
        $vsix = Get-VsixExtenstionFromMarketplace -ExtensionMarketPlaceName $_
        @{
            VsixName = $vsix.ExtensionName
            VsixId = $vsix.VsixId
            AllPackages = $allPackages
        }
    }
    if ($testCases.Count -gt 0) {
        It "Extension <VsixName> is installed" -TestCases $testCases {
            $objVsix = $AllPackages | Where-Object { $_.id -eq $VsixId }
            $objVsix | Should -Not -BeNullOrEmpty
        }
    }
}
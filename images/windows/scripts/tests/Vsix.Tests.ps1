Describe "Vsix" {
    $toolset = Get-ToolsetContent
    $requiredVsixPackages = $toolset.visualStudio.vsix

    $allPackages = (Get-VisualStudioInstance).Packages
    $testCases = $requiredVsixPackages | ForEach-Object {
        $vsixPackage = Get-VsixInfoFromMarketplace $_
        @{
            VsixName    = $vsixPackage.ExtensionName
            VsixId      = $vsixPackage.VsixId
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

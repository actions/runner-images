
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "PipxPackages" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    $pipxToolset = Get-ToolsetValue "pipx"
    $testCases = $pipxToolset | ForEach-Object { @{package = $_.package; cmd = $_.cmd} }
    It "<package>" -TestCases $testCases {
        "$cmd" | Should -ReturnZeroExitCode
    }
}
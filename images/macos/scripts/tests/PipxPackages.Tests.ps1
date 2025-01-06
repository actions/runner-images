
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "PipxPackages" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    $pipxToolset = (Get-ToolsetContent).pipx
    $testCases = $pipxToolset | ForEach-Object { @{package = $_.package; cmd = $_.cmd} }
    It "<package>" -TestCases $testCases {
        "$cmd" | Should -ReturnZeroExitCode
    }
}

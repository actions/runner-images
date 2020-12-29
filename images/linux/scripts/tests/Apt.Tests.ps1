Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$cmd = (Get-ToolsetContent).apt.cmd_packages

Describe "Apt" {

    $testCases = $cmd | ForEach-Object {
        @{ toolName = $_ }
    }

    It "<toolName> is available" -TestCases $testCases {
        (Get-Command -Name $toolName).CommandType | Should -BeExactly "Application"
    }
}
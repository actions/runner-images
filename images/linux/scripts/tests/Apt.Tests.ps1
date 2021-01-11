Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$cmd = (Get-ToolsetContent).apt.cmd_packages

Describe "Apt" {

    $testCases = $cmd | ForEach-Object {
        @{ toolName = $_ }
    }

    It "<toolName> is available" -TestCases $testCases {
        if ($toolName -eq "p7zip-full")
        {
            $toolName = "p7zip"
        }

        if ($toolName -eq "subversion")
        {
            $toolName = "svn"
        }

        if ($toolName -eq "sphinxsearch")
        {
            $toolName = "searchd"
        }

        (Get-Command -Name $toolName).CommandType | Should -BeExactly "Application"
    }
}
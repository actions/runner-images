Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$cmd = (Get-ToolsetContent).apt.cmd_packages + (Get-ToolsetContent).apt.vital_packages

Describe "Apt" {

    $testCases = $cmd | ForEach-Object {
        @{ toolName = $_ }
    }

    It "<toolName> is available" -TestCases $testCases {
        if ($toolName -eq "acl")
        {
            $toolName = "getfacl"
        }

        if ($toolName -eq "aria2")
        {
            $toolName = "aria2c"
        }

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

        if ($toolName -eq "binutils")
        {
            $toolName = "strings"
        }

        if ($toolName -eq "coreutils")
        {
            $toolName = "tr"
        }

        if ($toolName -eq "net-tools")
        {
            $toolName = "netstat"
        }

        if ($toolName -eq "mercurial")
        {
            $toolName = "hg"
        }

        (Get-Command -Name $toolName).CommandType | Should -BeExactly "Application"
    }
}
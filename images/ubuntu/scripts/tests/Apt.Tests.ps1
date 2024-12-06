Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Apt" {
    $packages = (Get-ToolsetContent).apt.cmd_packages + (Get-ToolsetContent).apt.vital_packages
    $testCases = $packages | ForEach-Object { @{ toolName = $_ } }

    It "<toolName> is available" -TestCases $testCases {
        switch ($toolName) {
            "acl"               { $toolName = "getfacl"; break }
            "aria2"             { $toolName = "aria2c"; break }
            "p7zip-full"        { $toolName = "p7zip"; break }
            "subversion"        { $toolName = "svn"; break }
            "sphinxsearch"      { $toolName = "searchd"; break }
            "binutils"          { $toolName = "strings"; break }
            "coreutils"         { $toolName = "tr"; break }
            "net-tools"         { $toolName = "netstat"; break }
            "mercurial"         { $toolName = "hg"; break }
            "findutils"         { $toolName = "find"; break }
            "systemd-coredump"  { $toolName = "coredumpctl"; break }
        }

        (Get-Command -Name $toolName).CommandType | Should -BeExactly "Application"
    }
}

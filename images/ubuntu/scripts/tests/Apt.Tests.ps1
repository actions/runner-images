Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Apt" {
    $packages = (Get-ToolsetContent).apt.cmd_packages + (Get-ToolsetContent).apt.vital_packages
    $testCases = $packages | ForEach-Object { @{ toolName = $_ } }

    It "<toolName> is available" -TestCases $testCases {
        switch ($toolName) {
            "acl"               { $toolName = "getfacl"; break }
            "aria2"             { $toolName = "aria2c"; break }
            "libnss3-tools"     { $toolName = "certutil"; break }
            "p7zip-full"        { $toolName = "p7zip"; break }
            "7zip"              { $toolName = "7z"; break }
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

Describe "Apt acquire configuration" {
    # Asserts the effective values, because a setting written under a key apt does not read is silently
    # ignored and leaves the image on apt's defaults.
    # https://github.com/actions/runner-images/issues/14594
    # 22.04 and 24.04 arm64 are served by ports.ubuntu.com; 26.04 merged arm64 into the main archive.
    $usesPortsArchive = (Test-IsUbuntu22-Arm64) -or (Test-IsUbuntu24-Arm64)

    $settingsTestCases = @(
        @{ setting = "Acquire::Retries"; expectedValue = if ($usesPortsArchive) { "3" } else { "1" } }
        @{ setting = "Acquire::http::Timeout"; expectedValue = "15" }
        @{ setting = "Acquire::https::Timeout"; expectedValue = "15" }
        @{ setting = "Acquire::IndexTargets::deb::DEP-11::DefaultEnabled"; expectedValue = "false" }
    )

    It "<setting> is set to <expectedValue>" -TestCases $settingsTestCases {
        (Get-CommandResult "apt-config dump $setting").Output | Should -BeExactly "$setting `"$expectedValue`";"
    }

    It "APT::Acquire::Retries is not set" {
        (Get-CommandResult "apt-config dump APT::Acquire::Retries").Output | Should -BeNullOrEmpty
    }

    It "Apt sources resolve through the mirror list" -Skip:$usesPortsArchive {
        $sourcesFile = if (Test-IsUbuntu22) { "/etc/apt/sources.list" } else { "/etc/apt/sources.list.d/ubuntu.sources" }
        Get-Content $sourcesFile -Raw | Should -Match ([regex]::Escape("mirror+file:/etc/apt/apt-mirrors.txt"))
    }

    # The mirror list carries no arm64 packages for these releases, so pointing them at it would 404.
    It "Apt sources use the ports archive" -Skip:(-not $usesPortsArchive) {
        $sourcesFile = if (Test-IsUbuntu22) { "/etc/apt/sources.list" } else { "/etc/apt/sources.list.d/ubuntu.sources" }
        $aptSources = Get-Content $sourcesFile -Raw
        $aptSources | Should -Match ([regex]::Escape("ports.ubuntu.com/ubuntu-ports"))
        $aptSources | Should -Not -Match ([regex]::Escape("mirror+file:/etc/apt/apt-mirrors.txt"))
    }

    It "Mirror list entries have unique priorities" {
        $priorities = Get-Content "/etc/apt/apt-mirrors.txt" | ForEach-Object { ($_ -split "priority:")[1] }
        $priorities.Count | Should -BeGreaterThan 1
        ($priorities | Select-Object -Unique).Count | Should -BeExactly $priorities.Count
    }
}

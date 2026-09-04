Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "macFUSE installation" -Skip:(-not $os.IsSequoiaX64) {
    It "Installs the package and filesystem bundle" {
        "pkgutil --pkg-info io.macfuse.installer.components.core" | Should -ReturnZeroExitCode
        "/Library/Filesystems/macfuse.fs" | Should -Exist
    }

    It "Uses the expected Developer ID" {
        $output = bash -c "codesign -dv --verbose=4 /Library/Filesystems/macfuse.fs 2>&1"
        $output | Should -Match "TeamIdentifier=3T5GSNBU6W"
    }

}

Describe "macFUSE runtime" -Skip:(-not $os.IsSequoiaX64) {
    It "Records kernel extension approval" {
        $approved = bash -c "sudo sqlite3 /var/db/SystemPolicyConfiguration/KextPolicy `"SELECT allowed FROM kext_policy WHERE team_id = '3T5GSNBU6W' LIMIT 1;`""
        $approved.Trim() | Should -Be "1"
    }

    It "Loads the filesystem extension after reboot" {
        $loaded = bash -c "sudo /Library/Filesystems/macfuse.fs/Contents/Resources/load_macfuse && kmutil showloaded | grep -E 'io\.macfuse\.filesystems\.macfuse|io\.macfuse\.filesystems\.osxfuse'"
        $LASTEXITCODE | Should -Be 0
        $loaded | Should -Not -BeNullOrEmpty
    }
}

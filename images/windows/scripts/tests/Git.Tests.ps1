Describe "Git" {
    $gitTools = 'bash', 'awk', 'git', 'git-lfs'
    $gitTestCases = $gitTools | ForEach-Object {
        @{
            toolName = $_
            source = [regex]::Escape("$env:ProgramFiles\Git")
        }
    }

    It "<toolName> is installed" -TestCases $gitTestCases {
        "$toolName --version" | Should -ReturnZeroExitCode
    }

    It "<toolName> is located in '<source>'" -TestCases $gitTestCases {
        (Get-Command -Name $toolName).Source | Should -Match $source
    }

    It "Git core.symlinks=true option is enabled" {
        git config core.symlinks | Should -BeExactly true
    }

    It "GCM_INTERACTIVE environment variable should be equal Never" {
        $env:GCM_INTERACTIVE | Should -BeExactly Never
    }
}

Describe "SshHostkeys" {
    $sshHosts = 'github.com', 'ssh.dev.azure.com'
    $sshTestCases = $sshHosts | ForEach-Object {
        @{
            hostName = $_
        }
    }

    Context "OpenSSH" {
        It "KnownHosts for <hostname>" -TestCases $sshTestCases {
            $KnownHosts = "$env:ProgramData\ssh\ssh_known_hosts"
            $SshKeyGen = "$env:SystemRoot\System32\OpenSSH\ssh-keygen.exe"
            & $SshKeyGen -F $hostName -f $KnownHosts | Out-String | Should -Match "Host $hostname found"
        }

        It "SSH accepts <hostname> keys" -TestCases $sshTestCases {
            $SSHOptions='-o BatchMode=yes'
            $SshCmd = "$env:SystemRoot\System32\OpenSSH\ssh.exe"
            & $SshCmd $SSHOptions -T git@$hostName 2>&1 | Out-String | Should -Not -Match "Host key verification failed."
        }
    }
    Context "Git for Windows" {
        It "KnownHosts for <hostname>" -TestCases $sshTestCases {
            $KnownHosts = "$env:ProgramFiles\Git\etc\ssh\ssh_known_hosts"
            $SshKeyGen = "$env:ProgramFiles\Git\usr\bin\ssh-keygen.exe"
            & $SshKeyGen -F $hostName -f $KnownHosts | Out-String | Should -Match "Host $hostname found"
        }

        It "SSH accepts <hostname> keys" -TestCases $sshTestCases {
            $SSHOptions='-o BatchMode=yes'
            $SshCmd = "$env:ProgramFiles\git\usr\bin\ssh.exe"
            & $SshCmd $SSHOptions -T git@$hostName 2>&1 | Out-String | Should -Not -Match "Host key verification failed."
        }
    }
}

Describe "Docker" -Skip:(Test-IsWin11-Arm64) {
    It "docker is installed" {
        "docker --version" | Should -ReturnZeroExitCode
    }

    It "docker service is up" {
        "docker images" | Should -ReturnZeroExitCode
    }

    It "docker symlink" {
        "C:\Windows\SysWOW64\docker.exe ps" | Should -ReturnZeroExitCode
    }
}

Describe "DockerCompose" -Skip:(Test-IsWin11-Arm64) {
    It "docker compose v2" {
        "docker compose version" | Should -ReturnZeroExitCode
    }

}

Describe "DockerWinCred" -Skip:(Test-IsWin11-Arm64) {
    It "docker-wincred" {
        "docker-credential-wincred version" | Should -ReturnZeroExitCode
    }
}

Describe "DockerImages" -Skip:((Test-IsWin25-X64) -or (Test-IsWin11-Arm64)) {
    Context "docker images" {
        $testCases = (Get-ToolsetContent).docker.images | ForEach-Object { @{ ImageName = $_ } }

        It "<ImageName>" -TestCases $testCases {
            docker images "$ImageName" --format "{{.Repository}}" | Should -Not -BeNullOrEmpty
        }
    }
}

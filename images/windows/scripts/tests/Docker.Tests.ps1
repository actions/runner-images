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
    It "docker compose" {
        "docker compose version" | Should -ReturnZeroExitCode
    }

}

Describe "DockerWinCred" -Skip:(Test-IsWin11-Arm64) {
    It "docker-wincred" {
        "docker-credential-wincred version" | Should -ReturnZeroExitCode
    }
}

$skipDockerImages = (Test-IsWin25-X64) -or (Test-IsWin11-Arm64)

Describe "DockerImages" -Skip:$skipDockerImages {
    BeforeDiscovery {
        $testCases = @()
        if (-not $skipDockerImages) {
            $dockerImages = (Get-ToolsetContent).docker.images
            $testCases = $dockerImages | ForEach-Object { @{ ImageName = $_ } }
        }
    }

    Context "docker images" {
        if ($testCases.Count -gt 0) {
            It "<ImageName>" -TestCases $testCases {
                docker images "$ImageName" --format "{{.Repository}}" | Should -Not -BeNullOrEmpty
            }
        }
    }
}
